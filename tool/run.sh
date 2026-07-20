#!/usr/bin/env bash
# Runs the app against the real Supabase project. Credentials live in
# env/dev.json, which is gitignored; this script holds no secrets.
set -euo pipefail
cd "$(dirname "$0")/.."
if [[ ! -f env/dev.json ]]; then
  echo "env/dev.json missing. Create it with SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY." >&2
  exit 1
fi
exec flutter run --dart-define-from-file=env/dev.json "$@"
