{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    jetbrains.idea-oss
    telegram-desktop
    alejandra
    firefox
    btop
    ranger
    discord-canary
    zed-editor
    starship
    evil-helix
    cargo
    rustup
    tealdeer
    bacon
  ];
}
