{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
    ];
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    #    isNormalUser = true;
    username = "evelyn";
    homeDirectory = lib.mkForce "/home/evelyn";
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings = {
      pull.rebase = "true";
      user.name = "Evelyn";
      user.email = "vlad@nikulin.name";
    };
  };
  programs.cava = {
    enable = true;
    settings = {
      color = {
        foreground = ''
          '#090040'
        '';
      };
    };
  };

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
