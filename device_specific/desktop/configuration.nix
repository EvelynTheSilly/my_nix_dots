{config, lib, pkgs, inputs, ...}:
{
  networking.hostName = "desktop";
  imports = [
    ../../nixos/configuration.nix
    ./hardware-configuration.nix
  ];
  # Define the systemd service
  systemd.services.ssh2baaas = {
    description = "AutoSSH service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''${pkgs.autossh}/bin/autossh -M 22010 -N -R \*:5500:localhost:22 -C -i /home/vlad/.ssh/id_ed25519 -o "ServerAliveInterval=30" -o "ServerAliveCountMax=9999" wnik@bots.baaas.org'';
      Restart = "always";
      User = "root";
    };
  };
}
