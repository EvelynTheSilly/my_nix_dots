{config, lib, pkgs, inputs, ...}:
{
  imports = [
    ../../nixos/configuration.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "laptop";
}
