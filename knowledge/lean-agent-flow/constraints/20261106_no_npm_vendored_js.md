---
id: C-20261106-01
date: 2026-11-06
status: standing
areas: [frontend, tooling]
rule: No npm — vendor JS deps into assets/vendor/ and import from app.js/app.css; only the app.js/app.css bundles ship.
---
# No npm; JS dependencies vendored

Given by the operator 2026-11-06; reinforced by repo AGENTS.md ("only the
app.js and app.css bundles are supported").

- All JS dependencies (e.g. a 3D library, if chosen) are vendored into
  `assets/vendor/` and imported from `assets/js/app.js` (CSS from `app.css`).
- esbuild (already a mix dep) bundles; there is no package.json, no npm/npx
  step anywhere in the pipeline.
- Third-party library licenses are copied alongside the vendored file.
