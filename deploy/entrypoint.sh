#!/bin/sh
# Container entrypoint for Alaypz.
#
# Single-node SQLite deployment: exec the release server as PID 1.
# `bin/server` sets PHX_SERVER=true (rel/overlays/bin/server) and execs
# the release. Migrations need no separate step: Alaypz.Application
# supervises {Ecto.Migrator, repos: …, skip: RELEASE_NAME == nil}, so a
# release boot (RELEASE_NAME set) runs the pending migrations itself,
# before the endpoint starts accepting traffic — schema and image stay
# in lockstep on every start, and there is no migration job to forget.
# `exec` so the BEAM receives SIGTERM for a clean shutdown.
set -eu

cd /app

exec ./bin/server
