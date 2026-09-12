{
  pkgs,
  lib,
  ...
}: {
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;
  boot.loader.limine = {
    enable = true;
    secureBoot = {
      enable = true;
      autoGenerateKeys = true;
      autoEnrollKeys.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
