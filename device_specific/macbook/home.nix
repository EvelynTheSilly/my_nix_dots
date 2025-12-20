{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home-manager/common/helix.nix
  ];
  
  home.username = "evelyn";
  home.homeDirectory =  "/Users/evelyn";
  home.stateVersion = "23.05";
}
