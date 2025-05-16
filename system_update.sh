#!/usr/bin/env bash

git add ./*
read -p "Commit message: " message
git commit -m "$message"

echo "Switch now or upgrade on reboot?\n"
echo "switch to switch now, boot to switch on reboot\n"

read -p "switch or boot: " switch_or_boot

nixos-rebuild $switch_or_boot --flake . --use-remote-sudo
