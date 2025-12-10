{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    settings = {
      theme = lib.mkForce "tokyonight";
      editor = {
        line-number = "relative";
        completion-timeout = 5;
        clipboard-provider = "wayland";
        cursor-shape = {
          insert = "bar";
        };
      };
    };
  };
}
