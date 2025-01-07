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
        modules-left = ["custom/power" "hyprland/workspaces"];
        modules-right = ["tray" "backlight" "cpu" "memory" "battery" "pulseaudio" "clock"];
        cpu = {
          format = " {usage}%";
        };
        memory = {
          format = " {}%";
        };
        pulseaudio = {
          format = " {volume}%";
        };
        "custom/power" = {
          format = "pwr";
          tooltip = false;
          on-click = "wlogout";
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
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;


      /* Base styling for the bar */
        #waybar {
          background: @base; /* Dark background */
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
