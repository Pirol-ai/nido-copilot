#!/bin/sh
# Does this repository actually give Copilot the nido skill?
#
# Everything happens in a throwaway HOME, so the person's own Copilot (~/.copilot) is not touched.
#
# With no argument it installs this working copy as a plugin. With `published` it walks the path a
# newcomer walks instead — add the marketplace from GitHub and install nido from it — which checks
# what is pushed to Pirol-ai/nido-copilot, not the working copy.
#
# Run it from anywhere:  sh check.sh [published]

set -eu

repo=$(cd "$(dirname "$0")" && pwd)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

HOME="$work/home"
mkdir -p "$HOME"
export HOME

fail() {
  echo "FAILED: $1" >&2
  exit 1
}

echo "1. the install"
if [ "${1:-}" = "published" ]; then
  copilot plugin marketplace add Pirol-ai/nido-copilot >"$work/add.txt" 2>&1 || fail "copilot would not add the marketplace
$(cat "$work/add.txt")"
  copilot plugin install nido@nido-copilot >"$work/install.txt" 2>&1 || fail "the plugin would not install
$(cat "$work/install.txt")"
else
  copilot plugin install "$repo" >"$work/install.txt" 2>&1 || fail "the plugin would not install
$(cat "$work/install.txt")"
fi
grep -q 'Installed 1 skill' "$work/install.txt" || fail "the install brought no skill
$(cat "$work/install.txt")"

echo "2. what Copilot made of it"
copilot plugin list >"$work/list.txt" 2>&1 || fail "copilot plugin list did not run"
grep -q '• nido' "$work/list.txt" || fail "the plugin is not installed
$(cat "$work/list.txt")"
copilot skill list >"$work/skills.txt" 2>&1 || fail "copilot skill list did not run"
grep -q '^ *nido - ' "$work/skills.txt" || fail "Copilot does not list the nido skill
$(cat "$work/skills.txt")"

echo
echo "Both passed."
