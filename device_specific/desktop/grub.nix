{pkgs, lib, ...}: let
    theme = pkgs.writeTextFile {
        name = "theme.txt";
        text = ''

        '';
    };
in{
    boot.loader.grub = {
        enable = true;
        version = 2;
        devices = ["/dev/sda3"];
        #theme = ./grub/catpuccin-mocha-grub-theme;
        useOSProber = true;
        timeout = 1;
    };
}
