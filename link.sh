#!/usr/bin/env bash

set -e
dir=$(pwd)

sudo ln -fs "${dir}/configuration.nix" /etc/nixos/configuration.nix
sudo ln -fs "${dir}/flake.nix" /etc/nixos/flake.nix
