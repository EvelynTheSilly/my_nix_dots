{
  pkgs,
  lib,
  ...
}: {
  homebrew = {
    enable = true;
    brews = [ "koekeishiya/formulae/yabai" ];
  };

  environment.systemPackages = with pkgs; [
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
