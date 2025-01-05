{pkgs,lib,inputs,...}:

{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];
    # enables xwayland (isnt that obvious from the text?)
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER"; 
      "$term" = "kitty";
      "$runner" = "wofi --show drun";
      "$screenshotter" = "hyprshot --mode region --clipboard-only";
      
      bind = [
        #focus moving
        "$mod, H, hy3:movefocus, l"
        
        "$mod, L, hy3:movefocus, r"
        
        "$mod, K, hy3:movefocus, u"
        
        "$mod, J, hy3:movefocus, d"

        #window moving
        "$mod SHIFT, H, hy3:movewindow, l"
        
        "$mod SHIFT, L, hy3:movewindow, r"
        
        "$mod SHIFT, K, hy3:movewindow, u"
        
        "$mod SHIFT, J, hy3:movewindow, d"

        "$mod CONTROL_L, L, resizeactive, -40 0"

        "$mod CONTROL_L, H, resizeactive, 40 0"

        "$mod CONTROL_L, K, resizeactive, 0 40"

        "$mod CONTROL_L, J, resizeactive, 0 -40"     
        
        #move workspace to other monitor
        "$mod, left, movecurrentworkspacetomonitor, 0"
        "$mod, right, movecurrentworkspacetomonitor, 1"

        
        "$mod, T, exec, kitty"
        
        "$mod, F, togglefloating"

        "$mod, Y, exec, kitty --hold -e btop"
        
        "$mod, B, exec, firefox"

        "$mod, D, exec, $runner"

        "$mod, S, exec, $screenshotter"

        "$mod, Q, killactive,"

        "$mod, C, togglesplit"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move app to] workspace {1..9}
        # also binds $mod {1..9} to move user to workspace {1..9} 
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
            ]
          )
          9)
      );
      env = [
        "HYPRCURSOR_THEME,catppuccin-latte-mauve-crusors"
        "HYPRCURSOR_SIZE,24"
      ];
      input = {
        kb_layout = [
          "us, ru"
        ];
        kb_options = [
          "grp:win_space_toggle"
        ];
      };
      monitor = [
        "DP-1, 3440x1440@165, 0x0, 1"
        "DP-2, 1920x1080@100, 3440x0,1"
      ];
      # mouse bindings
      bindm = [
        # move window
        "$mod, mouse:272, movewindow"
        # resize
        "$mod, mouse:273, resizewindow"
        # alt left click to also resize
        "$mod ALT, mouse:272, resizewindow"
      ];
      exec-once = [
        "$term"
        "hyprpaper"
        "hyprland-per-window-layout"
        "waybar -l debug > ~/waybar_logs.txt"
        "dunst"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];
      decoration = {
        inactive_opacity = 1;
      };
      misc = {
        force_default_wallpaper = 1;
      };
      general = {
        layout = "hy3";
      };
      plugin = {
        hy3 = {
          autotile = {
            enable = true;
          };
        };
      };
    };
  };
}
