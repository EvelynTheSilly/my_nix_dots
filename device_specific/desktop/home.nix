{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/common/home.nix
    ../../modules/home-manager/common/fastfetch.nix
    ../../modules/home-manager/common/helix.nix
    ../../modules/home-manager/common/themes.nix
    ../../modules/home-manager/hyprland/hypr.nix
    #../../modules/home-manager/niri/niri.nix
    #../../modules/home-manager/WMutils/anyrun/anyrun.nix
    ../../modules/home-manager/WMutils/waybar/waybar.nix
    ../../modules/home-manager/WMutils/hyprutils/hyprutils.nix
    ../../modules/home-manager/WMutils/wlogout/wlogout.nix
    ../../modules/home-manager/term/kitty.nix
    ../../modules/home-manager/term/alacritty.nix
    ../../modules/home-manager/shell/nu.nix
  ];
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-1, 3440x1440@165, 0x0, 1"
        "DP-2, 1920x1080@100, 3440x0, 1"
        "DP-3, 3840x2160@60, 5360x0, 1, transform, 1"
      ];
    };
  };
  services.hyprpaper = {
    settings = {
      preload = [
        "~/images/wallpapers/wp.png"
        "~/images/wallpapers/wp2.png"
      ];
      wallpaper = [
        "DP-1, ~/images/wallpapers/wp.png"
        "DP-2, ~/images/wallpapers/wp2.png"
      ];
    };
  };
}
