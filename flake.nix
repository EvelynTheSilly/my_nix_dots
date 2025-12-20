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

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    catppuccin.url = "github:catppuccin/nix";

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    catppuccin,
    niri,
    noctalia,
    quickshell,
    darwin,
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
          {
            #home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            #home-manager.users.home.stateVersion = "23.05";
            home-manager.users.evelyn.imports = [
              ./device_specific/desktop/home.nix
              catppuccin.homeManagerModules.catppuccin
              niri.homeModules.config
            ];
          }
          #niri.nixosModules.niri
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

    darwinConfigurations."Evelyns-Macbook-Pro" = darwin.lib.darwinSystem {
      modules = [
        ./device_specific/macbook/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.evelyn = ./device_specific/macbook/home.nix;
        }
      ];
    };
  };
}
