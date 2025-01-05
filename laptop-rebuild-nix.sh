#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

sudo nixos-rebuild switch --flake .#laptop
home-manager switch --flake .#vlad@laptop
