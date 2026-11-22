{
  description = "NixOS Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    umbriel.url = "github:noctalia-dev/umbriel/cachix";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, umbriel, noctalia, ... }: {
    nixosConfigurations.fern = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ 
        ./hosts/laptop/default.nix

	umbriel.nixosModules.default
	noctalia.nixosModules.default

        home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "home-manager-backup";
	  home-manager.extraSpecialArgs = { inherit inputs; };
	  home-manager.users.nick = import ./modules/home.nix;
        }
      ];
    };
  };
}
