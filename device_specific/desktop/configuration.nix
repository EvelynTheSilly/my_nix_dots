{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  networking.hostName = "desktop";
  imports = [
    ../../nixos/configuration.nix
    ./hardware-configuration.nix
  ];
  environment.systemPackages = with pkgs; [
  ];
}
