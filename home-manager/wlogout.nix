{pkgs, lib,...}:


{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "shutdown now";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
    ];
  };
}
