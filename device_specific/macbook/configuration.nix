{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/darwin/common/packages.nix
    ../../modules/darwin/common/configuration.nix
    ../../modules/darwin/aerospace/common.nix
  ];

  users.users.evelyn.home = "/Users/evelyn";
  system.stateVersion = 6;
}
