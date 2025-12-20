{
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.2;
      cursor_shape = "beam";
      cursor_trail = 1;
      shell = "nu";
      editor = "hx";
      notify_on_cmd_finish = "unfocused";
    };
  };
}
