{pkgs,lib,...}:


{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 50;
        modules-left = [ "custom/power" "hyprland/workspaces" ];
        modules-right =  ["tray" "cpu" "memory" "pulseaudio" "clock" ]; 
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
          tooltip = "Power";
          on-click = "wlogout";
          on-click-right = "wlogout";
          class = "power-button";
        };
      };      
    };
    style = ''
        /* Base styling for the bar */
        #waybar {
          background: #1e1e2e; /* Dark background */
          color: #ffffff;      /* White text color */
          font-family: "Hack Nerd Font", "FiraCode Nerd Font", sans-serif;
          font-size: 14px;
          padding: 5px 10px;
          border-bottom: 2px solid #89b4fa; /* Accent color */
        }

        /* Styling for individual modules */
        #waybar .module {
          margin: 0 5px;
          padding: 5px 8px;
          border-radius: 5px;
          background: #313244; /* Slightly lighter background for modules */
        }

        /* Styling for the clock module (example) */
        #waybar .module.clock {
          background: #89b4fa; /* Blue background for clock */
          color: #1e1e2e;      /* Dark text color */
        }

        /* Hover effect for modules */
        #waybar .module:hover {
          background: #89dceb; /* Lighter blue on hover */
          color: #1e1e2e;
          transition: background 0.3s, color 0.3s;
        }

        /* Active or focused workspace styling */
        #waybar .module.workspaces .active {
          font-weight: bold;
          color: #a6e3a1; /* Green accent for active workspace */
        }

        /* Inactive workspaces */
        #waybar .module.workspaces .inactive {
          color: #585b70; /* Dimmed color for inactive workspaces */
        }

        /* Separator styling */
        #waybar .separator {
          color: #89b4fa;
          margin: 0 5px;
        }

      '';
    
  };
} 
