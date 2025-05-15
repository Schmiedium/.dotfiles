#!/usr/bin/env bash

git add ./configuration.nix
git add ./flake.nix
git add ./flake.lock
read -p "Commit message: " message
git commit -m "$message"
git push

echo "Switch now or upgrade on reboot?\n"
echo "switch to switch now, boot to switch on reboot\n"

read -p "switch or boot: " switch_or_boot

nixos-rebuild $switch_or_boot --flake . --use-remote-sudo
