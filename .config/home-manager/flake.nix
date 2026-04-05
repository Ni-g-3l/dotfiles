{
  description = "Home Manager configuration for nig3l";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rio.url = "github:raphamorim/rio/main";
  };

  outputs = { self, nixpkgs, home-manager, rio, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in

    {
      homeConfigurations.nig3l = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ({ pkgs, ... }: {
            programs.rio = {
              enable = true;
              package = rio.packages.${pkgs.system}.rio;
            };
          })
          ./home.nix
        ];
      };
    };
}
