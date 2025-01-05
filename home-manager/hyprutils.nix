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
    settings = {
      background = {
        monitor = "";
        path = "~/images/wallpapers/lockscreen.png";
      };
      input-field = {
        monitor = "";
        size = "200,50";
        outline_thickness = 3;
        #fade_on_empty = true;
        #fade_timeout = 1000;
        placeholder_text = "<i>Input Password...</i>";
        fail_color = "rgb(203,136,34)";
        halign = "center";
        valign = "center";
      };
    };
  };
} 
