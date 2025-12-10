{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.x86_64-linux.default
  ];
}
