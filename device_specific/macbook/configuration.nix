{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    firefox
    (discord-canary.override {withVencord = true;})
  ];
  users.users.evelyn.home = "/Users/evelyn";
  system.stateVersion = 6;
}
