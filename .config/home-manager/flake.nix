{
  description = "Home Manager configuration for nig3l";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rio.url = "github:raphamorim/rio/main";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, rio, zen-browser, ... } @ inputs:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in

    {
      homeConfigurations.nig3l = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ({ pkgs, ... }: {
            programs.rio = {
              enable = true;
              package = rio.packages.${system}.rio;
            };
          })
          ./home.nix
        ];
      };
    };
}
