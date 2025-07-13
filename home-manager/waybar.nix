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

        * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font", monospace;
          font-size: 13px;
          min-height: 0;
          color: white;
        }

        window#waybar {
          background: linear-gradient(to right, #2b1e59, #3a1e66);
          border-bottom: 2px solid #4c1d95;
          padding: 0px 6px;
        }

        #workspaces button {
          color: #d1d5db;
          padding: 0 8px;
          margin: 0 2px;
          border-radius: 6px;
          background-color: transparent;
        }

        #workspaces button.active {
          background-color: #5b21b6;
          color: white;
          font-weight: bold;
        }

        #workspaces button:hover {
          background-color: #7c3aed;
          color: white;
        }

        #battery,
        #cpu,
        #memory,
        #temperature,
        #network,
        #pulseaudio,
        #clock,
        #tray,
        #custom-weather,
        #custom-discord,
        #custom-heart,
        #custom-keyboard,
        #custom-power {
          padding: 0 8px;
          margin: 0 4px;
          background-color: rgba(255, 255, 255, 0.05);
          border-radius: 8px;
        }

        #battery.critical,
        #battery.warning {
          background-color: #ef4444;
          color: white;
        }

        #temperature.critical {
          background-color: #b91c1c;
          color: white;
        }

        #clock {
          font-weight: bold;
          padding-right: 10px;
        }

        #tray {
          margin-left: 10px;
        }

    '';
  };
}
