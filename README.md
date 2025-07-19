# Eve's dots

my nix dots
feel free to use as inspiration/copy
mainly for use by my friends for inspo
~shoutout maddie~

# dir structure

- device specific
  contains device specific configurations for my laptop and desktop
  they import the baseline configs aswell as containing the ones specific to the device
  also includes hardware config for the devices
- nixos
  contains the configuration.nix imported by both device configs
- home-manager
  home manager configurations split by app
  also includes nushell config
  anything thats too small to deserve a whole file is in home.nix
  also includes empty template file with the baseline boilerplate for a file

# important files

- rebuild.sh
  rebuilds the system based on hostname,
  only rebuilds home manager upon changes in the home manager folder and rebuilding nix upon changes to nixos folder
  `./rebuild.sh -h` for more info
- flake.nix
  includes the home managed and nixos configs for laptop and pc (they only include the device specific files)
  to add a new device change flake.nix to add another device with new hostname
- flake.lock
  lockfile, defines package versions declarativley
  DO NOT EDIT MANUALLY
  `nix flake update` to update apps and programs in lockfile
