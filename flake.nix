{
  description = "Skye Lane Goetz: Nix Darwin Flake (1.0.0)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs @ {self, nixpkgs, flake-parts, nix-darwin, home-manager, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin"];
      flake = {
        darwinConfigurations.skyeav = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # or "x86_64-darwin" for Intel Macs
          specialArgs = {inherit inputs;};
          modules = [
            home-manager.darwinModules.home-manager
            ./configuration.nix
          ];
        };
      };
    };
}