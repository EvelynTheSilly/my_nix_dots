# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # You can also split up your configuration and import pieces of it here:
    ./hypr.nix
    ./waybar_rewrite.nix
    ./hyprutils.nix
    ./fastfetch.nix
    ./themes.nix
    ./wlogout.nix
    ./zed.nix
    ./niri.nix
    ./anyrun.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
    ];
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "vlad";
    homeDirectory = "/home/vlad";
  };

  home.packages = with pkgs; [
    dunst
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Evelyn";
    userEmail = "vlad@nikulin.name";
    extraConfig = {
      pull.rebase = "true";
    };
  };
  programs.cava = {
    enable = true;
    settings = {
      color = {
        foreground = ''
          '#090040'
        '';
      };
    };
  };

  # Term
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.2;
      cursor_shape = "beam";
      cursor_trail = 1;
      shell = "nu";
      editor = "hx";
      notify_on_cmd_finish = "unfocused";
    };
  };

  # Shell
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
