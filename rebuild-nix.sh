#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

export HOST=$(hostname)
sudo nixos-rebuild switch --flake .#nixos
home-manager switch --flake .#vlad@nixos
