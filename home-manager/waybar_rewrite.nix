{
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
       mainBar = {
        layer = "top";
        position = "top";
        height = 50;
        modules-left = [
          "custom/power"
          "hyprland/workspaces"
          "niri/workspaces"
        ];
        modules-centre = ["karlstav/cava"];
        modules-right = [
          "tray"
          "backlight"
          "cpu"
          "memory"
          "battery"
          "pulseaudio"
          "clock"
        ];
        cpu = {
          format = " {usage}%";
          on-click = "kitty --class btop --hold -e btop";
        };
        memory = {
          format = " {}%";
          on-click = "kitty --class btop --hold -e btop";
        };
        pulseaudio = {
          format = " {volume}%";
        };
        "custom/power" = {
          format = "pwr";
          tooltip = false;
          on-click = "wlogout -b 2";
          on-click-right = "wlogout --protocol layer-shell";
          class = "power-button";
        };
        clock = {
          tooltip-format = "{:%Y-%b-%d, %a}";
        };
        battery = {
          format = "{capacity}  ";
        };
        backlight = {
          format = "{percent}  ";
        };
      }; 
    };
  };
}
