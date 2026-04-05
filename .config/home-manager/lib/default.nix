###############################################################################
# Library Functions
# =============================================================================
# Helper functions for the Home Manager configuration.
# These functions are used by modules to simplify common tasks.
#
# USAGE:
#   Import this file in your modules:
#   
#   { lib ? import ../lib/default.nix { inherit pkgs; }, ... }:
#
#   Or use directly:
#   
#   let
#     lib = import ./lib/default.nix { pkgs = pkgs; };
#   in
#   
#   Then call functions:
#     lib.mkShellBin "my-script" "echo hello"
#     lib.flatpakPackage "com.discord.Discord"
#
###############################################################################

{ pkgs ? import <nixpkgs> {} }:

let
  # Nixpkgs library functions
  # Provides: mkIf, mkOption, mkEnableOption, mapAttrs, etc.
  lib = pkgs.lib;
in

{
  #############################################################################
  # mkShellBin - Create a shell script as a package
  # ==========================================================================
  # Creates a shell script that can be installed as a package.
  # The script will be available in PATH after running home-manager switch.
  #
  # Arguments:
  #   name    - Name of the script (used as command name)
  #   command - Shell script content
  #
  # Returns:
  #   A package containing the shell script at $out/bin/<name>
  #
  # Example:
  #   mkShellBin "hello" "echo 'Hello, World!'" 
  #   # Creates: $out/bin/hello
  #
  #############################################################################

  mkShellBin = name: command:
    pkgs.writeShellScriptBin name command;

  #############################################################################
  # flatpakPackage - Install a flatpak app if not present
  # ==========================================================================
  # Creates a package that runs flatpak install on activation.
  # Useful for ensuring flatpak apps are installed.
  #
  # Arguments:
  #   package - Flatpak app ID (e.g., "com.discord.Discord")
  #
  # Returns:
  #   A package that installs the flatpak on first run
  #
  # Example:
  #   flatpakPackage "com.zen_browser.zen"
  #   # Installs Zen Browser from Flathub
  #
  # Note: This is a fallback. For best results, use flatpak directly.
  #############################################################################

  flatpakPackage = package: 
    pkgs.writeShellScriptBin "flatpak-install-if-missing" ''
      flatpak install -y flathub ${package} 2>/dev/null || true
    '';

  #############################################################################
  # optionalPackage - Conditionally include a package
  # ==========================================================================
  # Wraps a package with a conditional check.
  #
  # Arguments:
  #   condition - Boolean (from config option)
  #   pkg       - Package to include if condition is true
  #
  # Returns:
  #   Package or empty value based on condition
  #
  # Example:
  #   optionalPackage config.enableFeature (pkgs.some-package)
  #   # Only includes package if config.enableFeature is true
  #
  #############################################################################

  optionalPackage = condition: pkg:
    lib.mkIf condition pkg;

  #############################################################################
  # fromYadm - Reference files from YADM directory
  # ==========================================================================
  # Helper to reference files from the old YADM configuration.
  # Useful during migration from YADM to Home Manager.
  #
  # Arguments:
  #   file - Path relative to yadm directory
  #
  # Returns:
  #   Path to the file in ../yadm/<file>
  #
  # Example:
  #   fromYadm "shell/aliases.sh"
  #   # Returns: ../yadm/shell/aliases.sh
  #
  # Note: These files are NOT managed by Home Manager until copied.
  #############################################################################

  fromYadm = file: ../yadm/${file};

  #############################################################################
  # fromYadmTools - Reference files from YADM tools directory
  # ==========================================================================
  # Helper to reference files from YADM tools subdirectories.
  #
  # Arguments:
  #   tool - Tool name (directory in yadm/tools/)
  #   file - Path relative to that directory
  #
  # Returns:
  #   Path to the file in ../yadm/tools/<tool>/<file>
  #
  # Example:
  #   fromYadmTools "dev" "install.sh"
  #   # Returns: ../yadm/tools/dev/install.sh
  #
  #############################################################################

  fromYadmTools = tool: file: ../yadm/tools/${tool}/${file};

  #############################################################################
  # mkOuterModule - Create a module with multiple sub-options
  # ==========================================================================
  # Helper to create a module structure with multiple options.
  # Used to group related options under a single namespace.
  #
  # Arguments:
  #   options - Attribute set of option definitions
  #
  # Returns:
  #   A module that can be imported
  #
  # Example:
  #   mkOuterModule {
  #     foo.enable = mkEnableOption "Foo feature";
  #     bar.enable = mkEnableOption "Bar feature";
  #   }
  #
  #############################################################################

  mkOuterModule = options:
    lib.evalModules {
      modules = [
        ({ config, ... }: {
          # Convert option definitions to mkOption
          options = lib.mapAttrs (name: opts: lib.mkOption opts) options;
        })
      ] ++ [
        ({ lib, ... }: {
          # Make pkgs and lib available as module arguments
          _module.args = {
            pkgs = lib.mkDefault pkgs;
            lib = lib;
          };
        })
      ];
    };

  #############################################################################
  # callPackageWith - Enhanced package calling
  # ==========================================================================
  # Extends lib.callPackageWith to include our custom pkgs and lib.
  # Allows modules to use helper functions when calling other packages.
  #
  # Usage:
  #   callPackageWith ./my-package.nix { ... }
  #
  #############################################################################

  callPackageWith = lib.callPackageWith (lib // {
    pkgs = pkgs;
    lib = lib;
  });
}
