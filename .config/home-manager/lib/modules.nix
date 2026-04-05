{ lib ? import ../lib/default.nix { inherit pkgs; },
  pkgs ? import <nixpkgs> {} 
}:

lib.mkOuterModule {
  custom.dev = lib.callPackageWith lib ./modules/programs/custom-dev.nix;
  custom.apps = lib.callPackageWith lib ./modules/programs/custom-apps.nix;
  custom.essentials = lib.callPackageWith lib ./modules/programs/custom-essentials.nix;
  shell = lib.callPackageWith lib ./modules/shell/default.nix;
}
