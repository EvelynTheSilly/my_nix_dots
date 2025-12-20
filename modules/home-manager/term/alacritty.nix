{
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        program = "nu";
        args = [];
      };
      env.EDITOR = "hx";
    };
    themePackage = pkgs.alacritty-theme;
    theme = "tokyo_night";
  };
}
