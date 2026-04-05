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
    # System monitoring
    # bottom (btm) - Cross-platform visual process monitor
    # Alternative: htop (in essentials module)
    bottom

    # Fuzzy finder
    # fzf - Command-line fuzzy finder
    # Used by many tools (vim, zsh, bash) for completion
    fzf

    # Version control
    # git - Distributed version control system
    # Essential for software development
    git

    # GNOME desktop integration
    # gnome-shell - GNOME Shell desktop
    # gnome-shell-extensions - Extensions for GNOME Shell
    # gnome-tweaks - GNOME tweak tool for customization
    # Note: Only needed if using GNOME desktop
    gnome-shell
    gnome-shell-extensions
    gnome-tweaks

    # Git TUI
    # lazygit - Simple terminal UI for Git commands
    # Usage: Press '?' for help, 'q' to quit
    # Alternative: lazygit (also in shell module)
    lazygit

    # Text editor
    # micro - Modern and intuitive terminal text editor
    # Alternatives: nvim, vim, emacs, nano
    micro

    # Search tool
    # ripgrep (rg) - Fast grep alternative
    # Usage: rg <pattern> <directory>
    ripgrep

    # Shell prompt
    # starship - Cross-shell prompt with git integration
    # Configuration: config/starship/starship.toml
    starship

    # File previewer
    # sushi - Quick previewer for GNOME Files (Nautilus)
    # Alternative: gnome-sushi
    sushi

    # Code editor
    # zed - High-performance code editor
    # Alternative: vscode, jetbrains-toolbox, subl
    zed-editor

    # Terminal multiplexer
    # zellij - Terminal multiplexer (like tmux/screen)
    # Configuration: config/zellij/config.kdl
    # Alternative: tmux (in shell module)
    zellij

    # Directory jumper
    # zoxide - Smarter cd that learns your habits
    # Usage: z <directory> (fuzzy matches)
    # Alternative: z (autojump), pushd/popd
    zoxide

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

    # Rio Flatpak version config
    ".var/app/com.rioterm.Rio/config/rio/config.toml".source = ./config/rio/config.toml;
    ".var/app/com.rioterm.Rio/config/rio/themes/gruvbox.toml".source = ./config/rio/themes/gruvbox.toml;

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

    # --------------------------------------------------------------------------
    # Shell Profile
    # --------------------------------------------------------------------------
    ".bash_profile".text = ''
      if [ -f ~/.bashrc ]; then
        source ~/.bashrc
        source ~/.userbashrc
      fi
    '';

    # --------------------------------------------------------------------------
    # User bashrc (shell setup: starship, zellij, zoxide, aliases)
    # --------------------------------------------------------------------------
    ".userbashrc".source = ./config/userbashrc;
  };
}
