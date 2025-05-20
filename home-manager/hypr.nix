{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.kitty.enable = true;
  # Variables for Hostnames
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      "$term" = ''
        kitty  nu -e "fastfetch"
      '';
      "$runner" = "wofi --show drun";
      "$screenshotter" = "hyprshot --mode region --clipboard-only";

      bind =
        [
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

          "$mod ,E , hy3:makegroup, tab" #make tab group

          "$mod SHIFT, E, hy3:makegroup, horizontal"

          "$mod SHIFT, E, hy3:makegroup, vertical"

          #move workspace to other monitor
          "$mod, left, movecurrentworkspacetomonitor, 0"
          "$mod, right, movecurrentworkspacetomonitor, 1"

          "$mod, T, exec, $term"

          "$mod, F, togglefloating"

          "$mod SHIFT, F, fullscreen"

          "$mod, Y, exec, sudo kitty --class btop --hold -e btop"

          "$mod, B, exec, firefox"

          "$mod, D, exec, $runner"

          "$mod, S, exec, $screenshotter"

          "$mod, Q, killactive,"

          "$mod, C, togglesplit"

          "$mod, V, exec, cliphist list | wofi -S dmenu -d | cliphist decode | wl-copy"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move app to] workspace {1..9}
          # also binds $mod {1..9} to move user to workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
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
      windowrulev2 = [
        "size,10x10,class:btop"
        "float,class:^(btop)$"
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
        "wl-paste --watch cliphist store"
        "$term"
        "hyprpaper"
        "hyprland-per-window-layout"
        "waybar"
        "swaync"
        "nm-tray"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];
      decoration = {
        inactive_opacity = 1;
      };
      general = {
        layout = "hy3";
            "col.activeborder" = "rgb(111,48,158)";
      };
      plugin = {
        hy3 = {
          autotile = {
            enable = true;
          };
          no_gaps_when_only = 2; # disable gaps when only one window on screen
        };
      };
    };
  };
}
