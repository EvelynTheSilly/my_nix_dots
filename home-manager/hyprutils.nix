{pkgs, lib,...}:


{
  services.hyprpaper = {
    enable = true;
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
  programs.hyprlock = {
    enable = true;

  };
} 
