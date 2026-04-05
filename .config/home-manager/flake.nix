{
  description = "Home Manager configuration for nig3l";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in

    {
      homeConfigurations.nig3l = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
}
