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
    extraConfig = ''
        /Windows
          protocol: efi
          path: guid(1f54566a-264c-4d7a-a6a0-5fce8c0dc99c):/efi/microsoft/boot/bootmgfw.efi
      '';
  };
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
