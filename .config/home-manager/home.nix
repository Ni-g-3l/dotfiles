###############################################################################
# Home Manager Configuration
# =============================================================================
# This is the main configuration file for Home Manager.
# It manages your user environment: packages, dotfiles, and settings.
#
# STRUCTURE:
#   imports     - Modular configuration files (modules/*)
#   home.*      - Home directory settings
#   programs.*  - Program-specific configurations
#   home.packages   - Packages to install
#   home.file      - Dotfiles to link
#
# USAGE:
#   Apply configuration:
#     home-manager switch -f ~/.config/home-manager/home.nix
#
#   Dry run (preview changes):
#     home-manager dry-activate -f ~/.config/home-manager/home.nix
#
#   Rollback to previous generation:
#     home-manager generations
#     home-manager rollback -g <GENERATION>
#
# MODULES:
#   To disable a module, remove it from imports or set enable = false:
#
#   # Disable shell module
#   shell.enable = false;
#
#   # Disable dev tools
#   custom.dev.enable = false;
#
# CONFIGURATION OPTIONS:
#   - home.packages: List of Nix packages to install
#   - home.file: Files/directories to link from config/ to ~/
#   - home.sessionVariables: Environment variables
#   - home.shellAliases: Command aliases
#   - programs.*: Program-specific settings
#
###############################################################################

{ config, pkgs, lib, ... }:

{

  #############################################################################
  # Module Imports
  # ==========================================================================
  # Modules can be enabled/disabled individually.
  #
  # To add a new module:
  #   1. Create module in modules/
  #   2. Import it here
  #
  #############################################################################

  imports = [
    # Development tools: rust, cmake, vlang, zed
    ./modules/dev.nix

    # Essential tools: build-essential, git, curl, xclip, nettools, htop
    ./modules/essentials.nix

    # Desktop apps: discord, zen-browser, blender, darktable, gimp
    ./modules/apps.nix
  ];

  #############################################################################
  # Home Directory Settings
  # ==========================================================================
  # Basic information about your home directory and user.
  # These are required for Home Manager to work correctly.
  #############################################################################

  # Your username (used for paths and identification)
  home.username = "nig3l";

  # Path to your home directory
  home.homeDirectory = "/home/nig3l";

  # Home Manager state version
  # Should match your NixOS version or approximate release date
  # Format: YY.MM (year.month)
  # Examples: "23.05", "24.05", "25.05"
  home.stateVersion = "25.05";

  #############################################################################
  # Home Manager Self-Management
  # ==========================================================================
  # Enable Home Manager to manage itself. This allows Home Manager to
  # upgrade itself when you run 'home-manager switch'.
  #############################################################################

  programs.home-manager.enable = true;

  #############################################################################
  # Bash
  # ==========================================================================
  # Configure Bash shell
  #############################################################################

  programs.bash = {
    enable = true;
    initExtra = builtins.readFile ./config/userbashrc;
  };

  #############################################################################
  # Starship
  # ==========================================================================
  # Enable Starship shell prompt
  #############################################################################

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  #############################################################################
  # Zellij
  # ==========================================================================
  # Enable Zellij terminal multiplexer
  #############################################################################

  programs.zellij.enable = true;

  #############################################################################
  # Zoxide
  # ==========================================================================
  # Enable Zoxide smarter cd
  #############################################################################

  programs.zoxide.enable = true;

  #############################################################################
  # FZF
  # ==========================================================================
  # Enable FZF fuzzy finder
  #############################################################################

  programs.fzf.enable = true;

  #############################################################################
  # Shell Aliases
  # ==========================================================================
  # Bash shell aliases
  #############################################################################

  home.shellAliases = {
    "s." = "source ~/.bashrc";
    "cd" = "z";
    "u." = "sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y";
    "g." = "git";
    "d." = "btm";
    "f." = "yazi";
    "lg." = "lazygit";
    "e." = "$EDITOR";
    "ll" = "eza -la --icons --git";
    "la" = "eza -a --icons";
    "l" = "eza --icons";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "t." = "go-task";
    "c." = "cargo";
    "r." = "rustc";
  };

  #############################################################################
  # Essentials
  # ==========================================================================
  # Enable essential CLI tools
  #############################################################################

  essentials.enable = true;

  #############################################################################
  # Development Tools
  # ==========================================================================
  # Enable development tools
  #############################################################################

  dev.enable = true;

  #############################################################################
  # Environment Variables
  # ==========================================================================
  # Session environment variables
  #############################################################################

  home.sessionVariables = {
    EDITOR = "micro";
    CARGO_HOME = "$HOME/.cargo";
    RUSTUP_HOME = "$HOME/.rustup";
  };

  #############################################################################
  # Application Modules
  # ==========================================================================
  # Enable desktop applications
  #############################################################################

  apps = {
    enable = true;
    discord = true;
    zen-browser = true;
    blender = true;
    darktable = true;
    gimp = true;
    bitwarden = true;
    spotify = true;
    teamviewer = true;
    rustdesk = true;
  };

  #############################################################################
  # Packages
  # ==========================================================================
  # List of packages to install. These come from nixpkgs.
  #
  # To search for packages:
  #   nix-env -qaP | grep <package-name>
  #   https://search.nixos.org/packages
  #
  # To add a package, add it to the list:
  #   pkgs.<package-name>
  #
  # To remove a package, remove it from the list.
  # Duplicate packages (in modules) will be automatically deduplicated.
  #############################################################################

  home.packages = with pkgs; [
    bashInteractive

    # GNOME desktop integration
    # gnome-shell - GNOME Shell desktop
    # gnome-shell-extensions - Extensions for GNOME Shell
    # gnome-tweaks - GNOME tweak tool for customization
    # Note: Only needed if using GNOME desktop
    gnome-shell
    gnome-shell-extensions
    gnome-tweaks

    # File previewer
    # sushi - Quick previewer for GNOME Files (Nautilus)
    # Alternative: gnome-sushi
    sushi

    # Graphics libraries for WebGPU (wgpu)
    # vulkan-loader - Vulkan loader
    # mesa - OpenGL implementation
    # libglvnd - GL Vendor-Neutral Dispatch library
    vulkan-loader
    mesa
    libglvnd

    # Containerization
    # docker - Container runtime
    # docker-compose - Multi-container orchestration
    docker
    docker-compose


    # Code editor
    # zed - High-performance code editor
    # Alternative: vscode, jetbrains-toolbox, subl
    zed-editor

    # Add more packages here:
    # pkgs.tree      # Display directory tree
    # pkgs.wget      # Download manager
    # pkgs.ffmpeg    # Audio/video converter
    # pkgs.imagemagick # Image manipulation
    # pkgs.zip       # Compression utilities
  ];

  #############################################################################
  # Dotfiles
  # ==========================================================================
  # Link configuration files from this repo to your home directory.
  #
  # Format:
  #   "<destination-path-in-home>".source = ./source-path;
  #
  # Examples:
  #   ".vimrc".source = ./vim/vimrc;
  #   ".config/nvim/init.vim".source = ./nvim/init.vim;
  #
  # The source path is relative to this home.nix file.
  # The destination path is relative to your home directory.
  #
  # Note: Files are symlinked, not copied. Changes to the source
  #       will be reflected immediately after running home-manager switch.
  #############################################################################

  home.file = {

    # --------------------------------------------------------------------------
    # bottom - System monitor
    # --------------------------------------------------------------------------
    # Process and system monitoring tool
    ".config/bottom/bottom.toml".source = ./config/bottom/bottom.toml;

    # --------------------------------------------------------------------------
    # micro - Terminal text editor
    # --------------------------------------------------------------------------
    # Modern terminal-based text editor
    ".config/micro/bindings.json".source = ./config/micro/bindings.json;
    ".config/micro/settings.json".source = ./config/micro/settings.json;
    ".config/micro/colorschemes/gruvbox.micro".source = ./config/micro/colorschemes/gruvbox.micro;

    # --------------------------------------------------------------------------
    # Nix configuration
    # --------------------------------------------------------------------------
    # Enable Nix flakes and nix-command
    ".config/nix/nix.conf".source = ./config/nix/nix.conf;

    # --------------------------------------------------------------------------
    # Rio - Terminal emulator
    # --------------------------------------------------------------------------
    # GPU-accelerated terminal emulator
    ".config/rio/config.toml".source = ./config/rio/config.toml;
    ".config/rio/themes/gruvbox.toml".source = ./config/rio/themes/gruvbox.toml;

    # --------------------------------------------------------------------------
    # Starship - Shell prompt
    # --------------------------------------------------------------------------
    ".config/starship.toml".source = ./config/starship/starship.toml;

    # --------------------------------------------------------------------------
    # Zellij - Terminal multiplexer
    # --------------------------------------------------------------------------
    # Terminal multiplexer with layout support
    ".config/zellij/config.kdl".source = ./config/zellij/config.kdl;
    ".config/zellij/layouts/base.kdl".source = ./config/zellij/layouts/base.kdl;


  };
}
