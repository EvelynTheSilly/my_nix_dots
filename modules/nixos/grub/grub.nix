{
  pkgs,
  lib,
  ...
}: let
  theme = pkgs.writeTextFile {
    name = "theme.txt";
    text = ''

    '';
  };
in {
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    #devices = ["/dev/sda"];
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
    theme = ./catppuccin-mocha-grub-theme;
    useOSProber = true;
  };
  boot.loader.timeout = 1;
}
