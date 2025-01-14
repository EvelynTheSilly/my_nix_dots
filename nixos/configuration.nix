# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
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

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  # Set your time zone.
  time.timeZone = "Europe/London";
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.ratbagd.enable = true;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
    };
  };
  #services.desktopManager.plasma6.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];


  security.polkit.enable = true;
  users.users.vlad = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      cbonsai
      trunk
      nil
      nixd
      nm-tray
      linuxKernel.packages.linux_6_6.perf
      hyprpaper
      tree
      vesktop
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
      lunarvim
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
    shellInit =  ''
      # Path to the OpenAI API key file
      OPENAI_KEY_FILE="$HOME/.config/env/openai.env"

      # Check if the file exists and is not empty
      if [ -f "$OPENAI_KEY_FILE" ] && [ -s "$OPENAI_KEY_FILE" ]; then
        export OPENAI_API_KEY=$(cat "$OPENAI_KEY_FILE")
      fi

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      fastfetch
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


  services.openssh.enable = true;

  # DO NOT EDIT
  system.stateVersion = "24.11"; # Did you read the comment?
}
