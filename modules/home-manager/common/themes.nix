{
  pkgs,
  lib,
  catppuccin,
  ...
}: {
  catppuccin.flavor = "mocha";
  catppuccin.enable = false;
  catppuccin.cursors = {
    enable = true;
    flavor = "latte";
    accent = "mauve";
  };
  catppuccin.zed.enable = false;
  catppuccin.hyprland.enable = false;
}
