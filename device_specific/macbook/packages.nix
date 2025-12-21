{
  pkgs,
  lib,
  ...
}: {

environment.systemPackages = with pkgs; [
    firefox
    btop
    ranger
    (discord-canary)
  ];}
