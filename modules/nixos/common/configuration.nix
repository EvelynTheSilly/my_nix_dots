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
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components; [
      gke-gcloud-auth-plugin
    ]
  );
in {
  programs.nix-ld.enable = true; # dynamic executable fix
  programs.nix-ld.libraries = with pkgs; [
    icu.dev
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  imports = [
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
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
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking = {
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    networkmanager.dns = "none";
    nameservers = ["1.1.1.1"];
    dhcpcd.enable = false; # Optional: disable dhcpcd if you're using NetworkManager or systemd-networkd
    useDHCP = false;
  };

  # Force systemd-resolved to use your config
  services.resolved = {
    enable = false;
    fallbackDns = ["1.1.1.1"]; # Again, your homelab first
    domains = ["~."]; # Apply DNS to all domains
    extraConfig = ''
      DNSStubListener=yes
    '';
  };
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  #ratbagd, for g502 mouse drivers
  services.ratbagd.enable = true;

  # LY display manager, basically just the login screen
  services.displayManager.ly = {
    enable = false;
    settings = {
      animation = "matrix";
      clear_password = true;
    };
  };
  # lemurs, aq different dm im trying out
  services.displayManager.lemurs = {
    enable = true;
    settings = {
      background = {
        show_background = true;
      };
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
  services.udev.extraRules = ''
        KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0666"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", TAG+="uaccess", TAG+="udev-acl"
        # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
  '';
  security.polkit.enable = true;
  users.users.evelyn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "audio"
      "pipewire"
      "plugdev"
    ]; # Enable sudo and network manager for the user.
  };
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
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
