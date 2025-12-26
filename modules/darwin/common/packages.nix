{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    firefox
    btop
    ranger
    discord-canary
    zed-editor
    
  ];
}
