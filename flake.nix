{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    catppuccin.url = "github:catppuccin/nix";
  };

<<<<<<< HEAD
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      hyprland,
      catppuccin,
      niri,
      #hy3,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          # > Our main nixos configuration file <
          modules = [
            ./device_specific/desktop/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            niri.nixosModules.niri
          ];
          laptop = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs outputs; };
            modules = [
              ./device_specific/laptop/configuration.nix
              catppuccin.nixosModules.catppuccin
              home-manager.nixosModules.home-manager
            ];
          };
        };

        # Standalone home-manager configuration entrypoint
        # Available through 'home-manager --flake .#your-username@your-hostname'
        homeConfigurations = {
          # FIXME replace with your username@hostname
          "vlad@desktop" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
            extraSpecialArgs = { inherit inputs outputs; };
            # > Our main home-manager configuration file <
            modules = [
              #hyprland.homeManagerModules.default
              ./device_specific/desktop/home.nix
              catppuccin.homeModules.catppuccin
            ];
          };
          "vlad@laptop" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
            extraSpecialArgs = { inherit inputs outputs; };
            # > Our main home-manager configuration file <
            modules = [
              #hyprland.homeManagerModules.default
              ./device_specific/laptop/home.nix
              catppuccin.homeModules.catppuccin
            ];
          };
        };

=======
  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    catppuccin,
    niri,
    #hy3,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ./device_specific/desktop/configuration.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          niri.nixosModules.niri
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./device_specific/laptop/configuration.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          niri.nixosModules.niri
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "vlad@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
          #hyprland.homeManagerModules.default
          ./device_specific/desktop/home.nix
          catppuccin.homeManagerModules.catppuccin
          niri.homeModules.config
        ];
      };
      "vlad@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
          #hyprland.homeManagerModules.default
          ./device_specific/laptop/home.nix
          catppuccin.homeManagerModules.catppuccin
          niri.homeModules.config
        ];
>>>>>>> be468d8 (Nix generation:)
      };
    };
}
