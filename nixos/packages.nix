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
  users.users.vlad.packages = with pkgs; [
    #Full user app list
    godot
    tealdeer
      xwayland-satellite
    ledger-live-desktop
    carapace
    gdk
    python3
    lutris
    google-cloud-sdk
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
    cbonsai
    github-cli
    cargo-generate
    trunk
    nil
    hyfetch
    nixd
    nm-tray
    linuxKernel.packages.linux_6_6.perf
    hyprpaper
    obs-studio
    tree
    (discord-canary.override {
      withVencord = true;
    })
    (discord-ptb.override {
      withVencord = true;
    })
    alejandra
    kind
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
    obsidian
    wasm-bindgen-cli
    vscodium
    kubectl
  ];
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
}
