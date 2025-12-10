{
  pkgs,
  lib,
  catppuccin,
  ...
}: {
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  catppuccin.cursors = {
    enable = true;
    flavor = "latte";
    accent = "mauve";
  };
  catppuccin.zed.enable = false;
}
