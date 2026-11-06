---
id: L-20261106-03
date: 2026-11-06
areas: [liveview, javascript, hooks]
touches: ["assets/js/hooks/**"]
rule: In LiveView 1.2 a hook's `handleEvent` is a *subscription* API — `this.handleEvent(name, payload => ...)` listens for the server-pushed `phx:<name>` window event; overriding it as a method named `handleEvent(event, payload)` receives nothing, because the client routes every server `push_event` through `liveSocket.dispatchEvent`, which is `window.dispatchEvent(new CustomEvent("phx:" + event, { detail: payload }))`.
---

# LV 1.2 routes server `push_event` to `phx:<event>` window events, not to a hook method

## Symptom

A `push_event/3` from a LiveComponent's `update/2` demonstrably reached the
client — the logged client diff carried `"e": [["alaypz-frame", …]]` — yet the
hook that defined `handleEvent(event, payload) { … }` never ran: its state
stayed at the mounted default, the canvas stayed blank, and the console was
clean (no errors, no warnings). The hook instance existed in
`liveSocket.roots[viewId].viewHooks` with its rAF loop running; only the
event delivery was missing.

## Cause

The LV 1.2 client does not call a hook's `handleEvent` method. Server events
in a diff are dispatched by `liveSocket.dispatchEvents(events)` →
`dispatchEvent(event, payload)` →
`dom.dispatchEvent(window, "phx:" + event, { detail: payload })` — a
**window-level `phx:<event>` CustomEvent**. The `ViewHook` base class exposes
`handleEvent(event, callback)`, which adds a `window.addEventListener(
"phx:" + event, …)` listener and tracks the ref in `__listeners` (auto-removed
in `__cleanup__`); `removeHandleEvent(ref)` unsubscribes. A hook that
*shadows* `handleEvent` with its own `(event, payload)` method never hears
anything: nothing calls it, and shadowing also orphans the base-class
listener bookkeeping. (LV ≤1.1 used the override-style API; the 1.2
AGENTS.md examples show the subscription form, but the docs don't warn that
the old override form now fails *silently*.)

## Rule

For server-pushed events, subscribe in `mounted`:
`this.handleEvent("name", payload => this.onName(payload))` (keep the handler
on a differently-named method — never override `handleEvent` itself);
listeners are cleaned up automatically when the hook is destroyed. Remember
the event arrives on **window** with the payload in `detail`, so *every*
mounted instance of that hook in the page receives it — guard per-element
state (e.g. static-mode instances should not subscribe at all).

## Related traps found the same session

- A `phx-hook` element must have a DOM `id`: `addHook` logs
  `hook.missing-id` and skips mounting (and `phx-update="ignore"` elements
  still get their hook on add/patch).
- Hooks are reachable for debugging at
  `window.liveSocket.roots[viewId].viewHooks` (keyed by an internal private
  `hookId`, not the DOM id); the registered definitions live at
  `window.liveSocket.hooks`.
- `mount/3` is `mount(params, session, socket)` — the second argument is the
  session; binding it as the socket crashes the first `assign` with a `%{}`.
