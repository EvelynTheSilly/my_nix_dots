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
        cursor-shape = {
          insert = "bar";
        };
      };
    };
  };
}
