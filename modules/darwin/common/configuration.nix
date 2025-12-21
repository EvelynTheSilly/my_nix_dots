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

  environment.extraInit = ''
    if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh
    fi
  '';
  security.pam.services.sudo_local.touchIdAuth = true;
}
