{
  description = ''
    SL Goetz NixDarwin
    skyeav@skyemac
    26.05 (Yarara) x86_64
    05-26-2026
  '';
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agent-of-empires = {
      url = "github:agent-of-empires/agent-of-empires";
    };
    hermes-agent = {
      url = "github:NousResearch/hermes-agent";
    };
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];
      flake.darwinConfigurations.skyeav = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/skyeav/user.nix
          inputs.home-manager.darwinModules.home-manager
          ./modules/skyeav/home.nix
          ./modules/settings.nix
          ./modules/global.nix
          inputs.nix-index-database.darwinModules.nix-index
        ];
      };
    };
}
