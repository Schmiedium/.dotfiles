#!/usr/bin/env bash
set -euo pipefail

FLAKE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UPDATE_INPUTS=false
INCLUDE_HOME=false
PUSH=false
REBUILD_MODE="switch"
COMMIT_MSG=""

usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -u, --update-inputs   Run 'nix flake update' before rebuilding"
    echo "  -H, --home            Also run 'home-manager switch' after system rebuild"
    echo "  -p, --push            Push to remote after a successful build"
    echo "  -b, --boot            Switch on next boot instead of immediately"
    echo "  -m, --message MSG     Commit message (default: auto-generated)"
    echo "  -h, --help            Show this help"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -u|--update-inputs) UPDATE_INPUTS=true ;;
        -H|--home)          INCLUDE_HOME=true ;;
        -p|--push)          PUSH=true ;;
        -b|--boot)          REBUILD_MODE="boot" ;;
        -m|--message)       COMMIT_MSG="$2"; shift ;;
        -h|--help)          usage; exit 0 ;;
        *) echo "Unknown option: $1"; usage; exit 1 ;;
    esac
    shift
done
cd "$FLAKE_DIR"

# Step 1: Update flake inputs if requested
if $UPDATE_INPUTS; then
    echo ">> Updating flake inputs..."
    nix flake update
fi

# Step 2: Commit any changes
git add -A
if ! git diff --cached --quiet; then
    if [[ -z "$COMMIT_MSG" ]]; then
        CHANGED=$(git diff --cached --name-only | tr '\n' ' ')
        COMMIT_MSG="update: $CHANGED($(date +%Y-%m-%d))"
    fi
    git commit -m "$COMMIT_MSG"
else
    echo ">> No changes to commit."
fi

# Step 3: Rebuild NixOS
echo ">> Running nixos-rebuild $REBUILD_MODE..."
if ! nixos-rebuild "$REBUILD_MODE" --flake . --sudo; then
    echo "!! nixos-rebuild failed. Aborting."
    exit 1
fi

GEN=$(nixos-rebuild list-generations | grep current | awk '{print $1}')
echo ">> System rebuild successful (generation $GEN)."

# Step 4: Home Manager
if $INCLUDE_HOME; then
    echo ">> Running home-manager switch..."
    if ! home-manager switch --flake .; then
        echo "!! home-manager switch failed."
        exit 1
    fi
    echo ">> Home Manager switch successful."
fi

# Step 5: Push
if $PUSH; then
    echo ">> Pushing to remote..."
    git push
fi

echo ">> Done."
