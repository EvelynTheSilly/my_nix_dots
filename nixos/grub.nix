{pkgs, lib, ...}: let
    theme = pkgs.writeTextFile {
        name = "theme.txt";
        text = ''

        '';
    };
in{
    boot.loader.grub = {
        enable = true;
        devices = ["/dev/sda"];
        #theme = ./grub/catpuccin-mocha-grub-theme;
        useOSProber = true;
    };
    boot.loader.timeout = 1;
}
