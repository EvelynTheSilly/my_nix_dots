{pkgs,lib,...}:

{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    # enables xwayland (isnt that obvious from the text?)
    xwayland.enable = true;
    # now that the good stuff right there
    settings = {
      # set mod to super/win key
      "$mod" = "SUPER"; 
      "$term" = "kitty";
      "$runner" = "wofi --show drun";

      # binds, all of them, like ALL of them
      bind = [
        #focus moving
        "$mod, H, movefocus, l"
        
        "$mod, L, movefocus, r"
        
        "$mod, K, movefocus, u"
        
        "$mod, J, movefocus, d"

        #move workspace to other monitor
        "$mod, left, movecurrentworkspacetomonitor, 0"
        "$mod, right, movecurrentworkspacetomonitor, 1"

        
        "$mod, T, exec, kitty"
        
        "$mod, F, togglefloating"
        
        "$mod, B, exec, firefox"

        "$mod, D, exec, $runner"

        "$mod, Q, killactive,"
      ]
      
      # shamefully copied off hypr wiki :(
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

      monitor = [
        "DP-1, 3440x1440@165, 0x0, 1"
        "DP-2, 1920x1080@100, 3440x0,1"
      ];
      # mouse bindings
      # copied of nix wiki :(
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
        "waybar"
        "dunst"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];
      decoration = {
        inactive_opacity = 0.9;
      };
      misc = {
        force_default_wallpaper = 1;
      };
    };
  };
}
