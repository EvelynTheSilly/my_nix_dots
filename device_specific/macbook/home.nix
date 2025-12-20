{
  pkgs,
  lib,
  ...
}: {
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/evelyn"
    else "/home/evelyn";
  home.stateVersion = "23.05";
}
