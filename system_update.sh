#!/usr/bin/env bash

git add ./configuration.nix
read -p "Commit message: " message
git commit -m "$message"
git push

echo "Switch now or upgrade on reboot?\n"
echo "switch to switch now, boot to switch on reboot\n"

read -p "switch or boot: " switch_or_boot

sudo nixos-rebuild $switch_or_boot --flake .
