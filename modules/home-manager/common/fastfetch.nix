{
  pkgs,
  lib,
  ...
}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        {
          type = "cpu";
          key = " ";
          showPeCoreCount = true;
          keyColor = "green";
        }
        {
          type = "gpu";
          key = " ";
          keyColor = "green";
        }
        {
          type = "memory";
          key = " ";
          keyColor = "green";
        }
        {
          type = "display";
          key = "󰍹 ";
          keyColor = "green";
        }
        {
          type = "disk";
          key = " ";
          keyColor = "green";
        }
        "break"
        {
          type = "os";
          key = " ";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = " ";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = " ";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = " ";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "wm";
          keyColor = "yellow";
        }
        "break"
        {
          type = "uptime";
          key = " ";
          keyColor = "blue";
        }
      ];
    };
  };
}
