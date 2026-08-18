{
  pkgs,
  lib,
  inputs,
  hy3,
  ...
}: let
  hyprlandLua = pkgs.writeText "hyprland.lua" ''
    -- Hyprland Lua Configuration

    -- Variables
    local mod = "SUPER"
    local term = "alacritty -e nu -e 'hyfetch'"
    local runner = "wofi --show drun"
    local screenshotter = "hyprshot --mode region --clipboard-only"

    -- Environment
    hl.env("HYPRCURSOR_THEME", "catppuccin-latte-mauve-crusors")
    hl.env("HYPRCURSOR_SIZE", "24")
    hl.env("XCURSOR_SIZE", "24")

    -- General
    hl.config({
      general = {
        layout = "hy3",
        ["col.active_border"] = "rgb(111,48,158)",
        border_size = 2,
      },
      decoration = {
        inactive_opacity = 1,
      },
      input = {
        kb_layout = "us, ru",
        kb_options = "grp:win_space_toggle",
      },
      -- plugin = {
      --   hy3 = {
      --     autotile = {
      --       enable = true,
      --     },
      --     no_gaps_when_only = 2,
      --   },
      -- },
    })

    -- Focus movement
    hl.bind(mod .. "+H", hl.dsp.focus({ direction = "left" }))
    hl.bind(mod .. "+L", hl.dsp.focus({ direction = "right" }))
    hl.bind(mod .. "+K", hl.dsp.focus({ direction = "up" }))
    hl.bind(mod .. "+J", hl.dsp.focus({ direction = "down" }))

    -- Window movement
    hl.bind(mod .. "+SHIFT+H", hl.dsp.window.move({ direction = "left" }))
    hl.bind(mod .. "+SHIFT+L", hl.dsp.window.move({ direction = "right" }))
    hl.bind(mod .. "+SHIFT+K", hl.dsp.window.move({ direction = "up" }))
    hl.bind(mod .. "+SHIFT+J", hl.dsp.window.move({ direction = "down" }))

    -- Window resize
    hl.bind(mod .. "+CTRL+L", hl.dsp.window.resize({ x = -40, y = 0 }))
    hl.bind(mod .. "+CTRL+H", hl.dsp.window.resize({ x = 40, y = 0 }))
    hl.bind(mod .. "+CTRL+K", hl.dsp.window.resize({ x = 0, y = 40 }))
    hl.bind(mod .. "+CTRL+J", hl.dsp.window.resize({ x = 0, y = -40 }))

    -- Move workspace to monitor (update monitor names to match your setup)
    -- hl.bind(mod .. "+left", hl.dsp.workspace.move({ monitor = "DP-1" }))
    -- hl.bind(mod .. "+right", hl.dsp.workspace.move({ monitor = "HDMI-A-1" }))
    -- hl.bind(mod .. "+up", hl.dsp.workspace.move({ monitor = "eDP-1" }))

    -- App launchers
    hl.bind(mod .. "+T", hl.dsp.exec_cmd(term))
    hl.bind(mod .. "+F", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(mod .. "+SHIFT+F", hl.dsp.window.fullscreen({ action = "toggle" }))
    hl.bind(mod .. "+B", hl.dsp.exec_cmd("firefox"))
    hl.bind(mod .. "+D", hl.dsp.exec_cmd(runner))
    hl.bind(mod .. "+S", hl.dsp.exec_cmd(screenshotter))
    hl.bind(mod .. "+Q", hl.dsp.window.close())
    hl.bind(mod .. "+V", hl.dsp.exec_cmd("cliphist list | wofi -S dmenu -d | cliphist decode | wl-copy"))

    -- Workspace binds (1-9)
    for i = 1, 9 do
      hl.bind(mod .. "+code:1" .. tostring(i - 1), hl.dsp.focus({ workspace = tostring(i) }))
      hl.bind(mod .. "+SHIFT+code:1" .. tostring(i - 1), hl.dsp.window.move({ workspace = tostring(i), follow = false }))
    end

    -- Mouse binds
    hl.bind(mod .. "+mouse:272", hl.dsp.window.drag())
    hl.bind(mod .. "+mouse:273", hl.dsp.window.resize())
    hl.bind(mod .. "+ALT+mouse:272", hl.dsp.window.resize())

    -- Autostart
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd(term)
    hl.exec_cmd("hyprland-per-window-layout")
    hl.exec_cmd("noctalia-shell")
    hl.exec_cmd("nm-tray")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    xwayland.enable = true;
    extraConfig = builtins.readFile hyprlandLua;
  };
}
