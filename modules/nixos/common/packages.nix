{
  pkgs,
  lib,
  ...
}: let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components; [
      gke-gcloud-auth-plugin
    ]
  );
in {
  users.users.evelyn.packages = with pkgs; [
    #Full user app list
    godot
    alacritty
    tealdeer
    #nirius
    xwayland-satellite
    carapace
    gdk
    python3
    lutris
    blueman
    bluez
    bluez-tools
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
    github-cli
    cargo-generate
    trunk
    nil
    hyfetch
    nixd
    perf
    obs-studio
    tree
    (discord-canary.override {
      withVencord = true;
    })
    (discord-ptb.override {
      withVencord = true;
    })
    alejandra
    docker
    keymapp
    neovim
    steam
    evil-helix
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
    vscodium
  ];
  environment.systemPackages = with pkgs; [
    wget
    libglvnd
    mesa
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    home-manager
    catppuccin-cursors
  ];
}
