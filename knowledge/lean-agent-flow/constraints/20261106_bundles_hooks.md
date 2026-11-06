---
id: C-20261106-03
date: 2026-11-06
status: standing
areas: [frontend, liveview]
rule: Only the app.js/app.css bundles; no inline <script>; JS interop via colocated hooks (`.Name`) or external phx-hooks registered in app.js.
---
# Bundles and hooks only

Repo AGENTS.md (phx.new v1.8 defaults).

- Layouts reference only the app.js / app.css bundles; vendor scripts are
  imported into app.js, vendor CSS into app.css.
- No inline `<script>` in HEEx; the game canvas is rendered by a `phx-hook`
  with `phx-update="ignore"`, driven by `push_event/3` from the server.
- Colocated hook names start with `.`; external hooks are registered in the
  LiveSocket constructor in app.js.
