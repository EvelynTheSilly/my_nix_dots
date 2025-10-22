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
    style = ''
        /* Base styling for the bar */
        #waybar {
          color: #ffffff;      /* White text color */
          font-family: "Hack Nerd Font", "FiraCode Nerd Font", sans-serif;
          font-size: 14px;
          padding: 5px 10px;
          border-bottom: 2px solid @blue; /* Accent color */
        }

        .modules-left {
            padding-left: 7px;
        }

        .modules-right {
          padding-right: 7px;
        }

        /* Styling for individual modules */
        #waybar .module {
          margin: 0 5px;
          padding: 5px 8px;
          border-radius: 5px;
          background: @surface0; /* Slightly lighter background for modules */
        }

        /* Active or focused workspace styling */
        #workspaces button.active {
          background-color: @lavender; /* Green accent for active workspace */
          color: @crust;
          font-weight: bold;
        }

       /* Inactive workspaces */
        #workspaces button.inactive {
          color: #585b70; /* Dimmed color for inactive workspaces */
        }

        /* Separator styling */
        #waybar .separator {
         margin: 0 5px;
        }
    '';
    
  };
}
