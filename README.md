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
- modules
  the folder that includes my home, nix, and darwin settings, split into 3 respective folders,
  selectively included by each of my devices depending on which ones they need 
  
# important files

- rebuild.sh
  rebuilds the system based on hostname,
  only rebuilds home manager upon changes in the home manager folder and rebuilding nix upon changes to nixos folder
  `./rebuild.nu -h` for more info
- flake.nix
  includes the home managed and nixos configs for laptop and pc (they only include the device specific files)
  to add a new device change flake.nix to add another device with new hostname
- flake.lock
  lockfile, defines package versions declarativley
  DO NOT EDIT MANUALLY
  `nix flake update` to update apps and programs in lockfile
