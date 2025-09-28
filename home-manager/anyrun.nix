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
      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libwebsearch.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/librink.so"
      ];
    };
  };
}
