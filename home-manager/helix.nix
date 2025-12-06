{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "'" = "'";
          };
          language-server.rustanalyzer = {
            command = "rust-analyzer";
          };
        }
      ];
    };
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
