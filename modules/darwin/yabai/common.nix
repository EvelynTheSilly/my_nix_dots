{
  pkgs,
  lib,
  ...
}: {
  services.yabai = {
    enable = false;
    config = {
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      window_placement = "second_child";
      window_opacity = "off";
      top_padding = 36;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };
    extraConfig = ''
      yabai -m signal --add event=system_woke action="yabai -m config focus_follows_mouse autoraise"
    '';
  };
}
