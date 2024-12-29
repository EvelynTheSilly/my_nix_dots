{pkgs, lib,...}:


{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/images/wp.png"
      ];
      wallpaper = [
        "DP-1, /images/wp.png"
      ];
    };
  };
} 
