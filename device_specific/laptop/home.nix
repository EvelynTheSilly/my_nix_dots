{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager/home.nix
  ];
  wayland.windowManager.hyprland = {
    # settings overwrites, this overwrites settings if they are previously set in a imported file
    settings = {
      monitor = [
        "eDP-1, 2160x1440@59.95, 0x0, 1"
      ];
    };
  };
  services.hyprpaper = {
    settings = {
      preload = [
        "~/images/wallpapers/wp.png"
      ];
      wallpaper = [
        "eDP-1, ~/images/wallpapers/wp.png"
      ];
    };
  };
}
