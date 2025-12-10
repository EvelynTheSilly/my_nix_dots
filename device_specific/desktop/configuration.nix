{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  networking.hostName = "desktop";
  imports = [
    ../../modules/nixos/common/configuration.nix
    ../../modules/nixos/common/packages.nix
    ../../modules/nixos/common/certs.nix
    ../../modules/nixos/grub/grub.nix
    #../../modules/nixos/niri/niri.nix
    ../../modules/nixos/noctalia/noctalia.nix
    ./hardware-configuration.nix
  ];
  environment.systemPackages = with pkgs; [
  ];
}
