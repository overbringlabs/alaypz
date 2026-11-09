#!/bin/sh
# Container entrypoint for Alaypz.
#
# Single-node SQLite deployment: migrate, then exec the release server as
# PID 1. `bin/server` sets PHX_SERVER=true (rel/overlays/bin/server) and
# execs the release. Running `bin/migrate` on every start is idempotent
# and keeps schema and image in lockstep — there is no separate migration
# job to forget. `exec` so the BEAM receives SIGTERM for a clean shutdown.
set -eu

cd /app

echo "==> running migrations"
./bin/migrate

echo "==> starting server"
exec ./bin/server
