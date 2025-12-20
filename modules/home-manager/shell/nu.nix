{
  pkgs,
  lib,
  ...
}: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
