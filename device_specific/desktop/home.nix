{inputs,lib,config,pkgs,...}:
{
  imports = [
    ../../home-manager/home.nix
  ];
  wayland.windowManager.hyprland = {
    # settings overwrites, this overwrites settings if they are previously set in a imported file
    settings = {
      monitor = [
        "DP-1, 3440x1440@165, 0x0, 1"
        "DP-2, 1920x1080@100, 3440x0, 1"
      ];  
    };
  };
  services.hyprpaper = {
    settings = {
      preload = [
        "~/images/wallpapers/wp.png"
        "~/images/wallpapers/wp2.png"
      ];
      wallpaper = [
        "DP-1, ~/images/wallpapers/wp.png"
        "DP-2, ~/images/wallpapers/wp2.png"
      ];
    };  
  };
}
