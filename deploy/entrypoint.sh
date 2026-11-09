#!/bin/sh
# Container entrypoint for Alaypz.
#
# Single-node SQLite deployment: migrate, then exec the release server as
# PID 1. The release has no bin/migrate (Mix.Release did not generate
# one), so migrations run through the release runner instead: `bin/alaypz
# evaluate` boots the app (repo configured from DATABASE_PATH by
# config/runtime.exs) and runs Alaypz.Release.migrate. Idempotent, so
# schema and image stay in lockstep on every start — there is no
# separate migration job to forget. `exec` so the BEAM receives SIGTERM
# for a clean shutdown.
set -eu

cd /app

echo "==> running migrations"
./bin/alaypz evaluate Alaypz.Release.migrate

echo "==> starting server"
exec ./bin/server
