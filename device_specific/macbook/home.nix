{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home-manager/common/helix.nix
    ../../modules/home-manager/term/kitty.nix
    ../../modules/home-manager/term/alacritty.nix
    ../../modules/home-manager/common/fastfetch.nix
    ../../modules/home-manager/shell/nu.nix
  ];
  
  home.username = "evelyn";
  home.homeDirectory =  "/Users/evelyn";
  home.stateVersion = "23.05";
}
