{
  pkgs,
  lib,
  ...
}: {
  programs.anyrun = {
    enabled = true;
    config = {
      closeOnClick = true;
      x = {
        fraction = 0.5;
      };
    };
  };
}
