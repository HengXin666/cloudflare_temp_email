#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
TOML_FILE="$PROJECT_DIR/worker/wrangler.toml"

if [ ! -f "$TOML_FILE" ]; then
    echo "Error: $TOML_FILE not found"
    exit 1
fi

REPO=$(git remote get-url origin | sed 's|.*github\.com[:/]||; s|\.git$||')

echo "Updating BACKEND_TOML secret for $REPO..."
gh secret set BACKEND_TOML --repo "$REPO" < "$TOML_FILE"
echo "Done. BACKEND_TOML updated at $(date -u +"%Y-%m-%dT%H:%M:%SZ")."
