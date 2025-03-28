# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in {
  programs.nix-ld.enable = true; # dynamic executable fix
  programs.nix-ld.libraries = with pkgs; [
    icu.dev
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    #Beta nvidia driver, use stable for latest stable
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  #ratbagd, for g502 mouse drivers
  services.ratbagd.enable = true;

  # LY display manager, basically just the login screen
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      clear_password = true;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  security.polkit.enable = true;
  users.users.vlad = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"]; # Enable sudo and network manager for the user.

    packages = with pkgs; [
      #Full user app list
      zerotierone
      tealdeer
      carapace
      gdk
      lutris
      google-cloud-sdk
      blueman
      bluez
      bc
      rustlings
      r2modman
      bottles
      transmission_4-qt
      tor-browser
      nushell
      starship
      swaynotificationcenter
      vlc
      dioxus-cli
      libnotify
      cliphist
      wl-clipboard
      cbonsai
      github-cli
      cargo-generate
      trunk
      nil
      nixd
      nm-tray
      linuxKernel.packages.linux_6_6.perf
      hyprpaper
      obs-studio
      tree
      (discord-canary.override {
        withVencord = true;
      })
      (
        discord-ptb.override {
          withVencord = true;
        }
      )
      kind
      docker
      keymapp
      neovim
      steam
      helix
      prismlauncher
      telegram-desktop
      fastfetch
      git
      rustup
      wofi
      cava
      waybar
      zig
      polkit_gnome
      hyprshot
      zed-editor
      clang
      piper
      libratbag
      hyprlock
      hyprland-per-window-layout
      killall
      ranger
      arandr
      btop
      obsidian
      wasm-bindgen-cli
      vscodium
      kubectl
    ];
    shell = pkgs.zsh;
  };
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git" # Essential Oh My Zsh plugin
      ];
      # Custom plugins location (ensure they are installed via Nix)
      customPkgs = [
        pkgs.zsh-autosuggestions
        pkgs.zsh-syntax-highlighting
        pkgs.zsh-powerlevel10k
      ];
    };
    shellInit = ''
      # Path to the OpenAI API key file
      OPENAI_KEY_FILE="$HOME/.config/env/openai.env"

      # Check if the file exists and is not empty
      if [ -f "$OPENAI_KEY_FILE" ] && [ -s "$OPENAI_KEY_FILE" ]; then
        export OPENAI_API_KEY=$(cat "$OPENAI_KEY_FILE")
      fi

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    libglvnd
    mesa
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    home-manager
    wlogout
    catppuccin-cursors
    autossh
  ];

  virtualisation.docker.enable = true;
  services.openssh.enable = true;

  # DO NOT EDIT
  system.stateVersion = "24.11"; # Did you read the comment?
}
