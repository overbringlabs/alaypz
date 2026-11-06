# Research — LiveView 1.2 footguns for an observable multiplayer game (2026-11-06)

Method: local SearXNG (192.168.88.14:8444) + local Firecrawl (192.168.88.73:3002),
grounded on hexdocs **v1.2.13** (our `phoenix_live_view ~> 1.2.0` resolves there) and
elixirforum threads.

Sources:
- hexdocs `Phoenix.LiveView` v1.2.13 module docs (`push_event/4` incl. `dispatch: :before`;
  `attach_hook` component support; stream container rules; `send_update/3` + component
  `update/2`).
- elixirforum: "Handling PubSub messages from within a LiveComponent?"
  (https://elixirforum.com/t/handling-pubsub-messages-from-within-a-livecomponent/41417)
- elixirforum: "Passing a livestream to a component/live_component issue"
  (https://elixirforum.com/t/passing-a-livestream-to-a-component-live-component-issue/62906)

## Confirmed footguns

1. **LiveComponents are not processes.** PubSub messages land in the *parent LiveView's*
   process; a component cannot `handle_info` or subscribe (no `phx-target` equivalent for
   PubSub). → Parent view subscribes once and dispatches via `send_update/3`
   (component `update/2`) or `attach_hook` + client event (the Livebook sidebar pattern).
2. **Streams belong to the view.** Assigning a stream into a component's assigns yields a
   plain value; `stream_insert` from a component into a parent stream fails (`KeyError
   :streams`), and a child must never insert into a parent's stream — the parent is the
   source of truth. → Per-card `send_update` instead of a stream of components; when a
   collection is DOM-heavy, stream *plain elements* in the view and keep state in assigns.
3. **`attach_hook` inside components supports only `:after_render`, `:handle_event`,
   `:handle_async`** (1.2.13 docs); view-level `attach_hook` is unrestricted. → Canvas
   hooks as colocated `.Hook` with `phx-update="ignore"` (no `attach_hook` needed).
4. **`push_event` flushes with the view's diff** — the client receives pushed events when
   the view re-renders; `push_event/4` `dispatch: :before` dispatches before the patch. →
   The game tick that calls `push_event/3` is itself the render; the `phx-hook` canvas
   receives state via `handleEvent` with a near-zero DOM diff.
5. **Stream containers:** `phx-update="stream"` must sit on the *immediate* parent of each
   stream with a unique DOM id; generated item ids must not be prefixed or altered;
   non-stream items inside the container need their own unique ids.

## Chosen pattern (server-authoritative; pending S2)

- One `GenServer` per game ticks the engine; state changes broadcast `game:{id}` (full
  state) and `lobby` (card summary: name, score, alive?).
- Lobby view subscribes once; dispatches with `send_update/3` to per-card
  LiveComponents. No component-side subscriptions.
- Focused game surface: canvas inside a `phx-hook` + `phx-update="ignore"`; the view
  pushes `game_state` via `push_event/3`; the hook renders and **tweens between the last
  two server states**, hiding one WebSocket round-trip of latency for everyone (player
  and spectators).
- Inputs: colocated keydown hook → `handle_event` → `GenServer.cast` to the game; the
  local player renders the same authoritative state as spectators — one engine, no
  rule divergence, spectator support comes for free.
