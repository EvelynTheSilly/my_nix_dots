{pkgs, lib,...};


{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        modules-left = [ "sway/workspaces" ];
        modules-right =  ["tray" "cpu" "memory" "backlight" "network" "pulseaudio" "clock"];
      };

      
    };
  };
} 
