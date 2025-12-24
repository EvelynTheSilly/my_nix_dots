{
  pkgs,
  lib,
  inputs,
  ...
}: let
  spawn_firefox = pkgs.writeTextFile {
    name = "spawn_script.sh";
    text = ''
      #! /usr/bin/env nix-shell
      #! nix-shell -i sh -p jq

      firefox &
      sleep 1

      pid=$(pgrep -n firefox)

      hyprctl -j clients | jq -r ".[] | select(.pid == $pid) | .address" |
      while read addr; do
        hyprctl dispatch movetoworkspacesilent 3,address:$addr
      done
    '';
    executable = true;
  };
  spawn_steam = pkgs.writeTextFile {
    name = "spawn_script.sh";
    text = ''
      #! /usr/bin/env nix-shell
      #! nix-shell -i sh -p jq

      steam &
      sleep 10

      pid=$(pgrep -n steam)

      hyprctl -j clients | jq -r ".[] | select(.pid == $pid) | .address" |
      while read addr; do
        hyprctl dispatch movetoworkspacesilent 3,address:$addr
      done
    '';
    executable = true;
  };
  spawn_discord = pkgs.writeTextFile {
    name = "spawn_script.sh";
    text = ''
      #! /usr/bin/env nix-shell
      #! nix-shell -i sh -p jq

      DiscordPTB &
      sleep 10

      pid=$(pgrep -n DiscordPTB)

      hyprctl -j clients | jq -r ".[] | select(.pid == $pid) | .address" |
      while read addr; do
        hyprctl dispatch movetoworkspacesilent 3,address:$addr
      done
    '';
    executable = true;
  };
in {
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
        alacritty -e nu -e "hyfetch"
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

          #"$mod SHIFT, E, hy3:makegroup, horizontal"

          #"$mod SHIFT, E, hy3:makegroup, vertical"

          #move workspace to other monitor
          "$mod, left, movecurrentworkspacetomonitor, 0"

          "$mod, right, movecurrentworkspacetomonitor, 1"

          "$mod, up, movecurrentworkspacetomonitor, 2"

          "$mod, T, exec, $term"

          "$mod, F, togglefloating"

          "$mod SHIFT, F, fullscreen"

          "$mod, B, exec, firefox"

          "$mod, D, exec, $runner"

          "$mod, S, exec, $screenshotter"

          "$mod, Q, killactive,"

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
        "XCURSOR_SIZE,24"
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
        "float,class:^(btop)$"

        "tag +pip, title:(Picture.?in.?[Pp]icture)"
        "float, tag:pip"
        "pin, tag:pip"
        "size 600 338, tag:pip"
        "keepaspectratio, tag:pip"
        "noborder, tag:pip"
        "opacity 1 1, tag:pip"
        "move 100%-w-40 4%, tag:pip"
      ];

      workspace = [
        "1,monitor:Dp-1"
        "2,monitor:Dp-3"
        "3,monitor:Dp-2"
        "8,monitor:Dp-1"
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
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "$term"
        spawn_discord
        spawn_firefox
        spawn_steam
        #"hyprpaper"
        "hyprland-per-window-layout"
        #"waybar"
        "noctalia-shell"
        "nm-tray"
        "blueman-applet"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];
      decoration = {
        inactive_opacity = 1;
      };
      general = {
        layout = "hy3";
        "col.active_border" = "rgb(111,48,158)";
        border_size = 2;
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
