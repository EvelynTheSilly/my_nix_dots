#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

sudo nixos-rebuild switch --flake .#desktop
home-manager switch --flake .#vlad@desktop
