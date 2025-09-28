{
  pkgs,
  lib,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      closeOnClick = true;
      x = {
        fraction = 0.5;
      };
    };
  };
}
