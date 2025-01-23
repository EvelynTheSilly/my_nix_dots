# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./hypr.nix
    ./waybar.nix
    ./hyprutils.nix
    ./fastfetch.nix
    ./themes.nix
    ./wlogout.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "vlad";
    homeDirectory = "/home/vlad";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    dunst
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "vlad";
    userEmail = "vlad@nikulin.name";
    extraConfig = {
      pull.rebase = "true";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.5;
    };
  };

  programs.zed-editor = {
    enable = true;
    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
      };
      vim_mode = true;
      format_on_save = "on";
            assistant = {
          default_model = {
            provider = "zed.dev";
            model = "claude-3-5-sonnet";
          };
          inline_alternatives = [
            {
              provider = "zed.dev";
              model = "gpt-4o";
            }
          ];
          version = 2;
        };
      };
  };
  programs.nushell = {
    configfile.source = ./config.nu;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
