#!/usr/bin/env sh

sudo nix-collect-garbage -d --delete-older-than 5d
