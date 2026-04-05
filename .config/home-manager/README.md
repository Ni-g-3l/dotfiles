# Home Manager Configuration

## Overview

This is a modular Home Manager configuration that manages your user environment declaratively. All packages, dotfiles, and settings are defined in Nix, making your setup reproducible and portable.

## Directory Structure

```
.
├── home.nix                      # Main configuration entry point
├── flake.nix                     # Flake-based configuration
├── bootstrap.sh                  # Initial setup script
├── lib/                          # Helper functions
│   └── default.nix
├── modules/                      # Modular configuration files
│   ├── dev.nix                  # Development tools
│   ├── essentials.nix           # Essential CLI tools
│   └── apps.nix                 # Desktop applications
├── config/                       # Tool configuration files
│   ├── userbashrc              # Shell setup
│   ├── starship/
│   ├── zellij/
│   └── ...
└── README.md
```

## Quick Start

### 1. Install Nix + Home Manager

```bash
# Run the bootstrap script
chmod +x bootstrap.sh
./bootstrap.sh

# Source the nix profile
source ~/.nix-profile/etc/profile.d/nix.sh
```

### 2. Apply Configuration

```bash
home-manager switch -f ~/.config/home-manager/home.nix
```

### 3. Update Configuration

After editing files, reapply:

```bash
home-manager switch -f ~/.config/home-manager/home.nix
```

## Modules

Each module handles a specific category of packages and configurations.

### Module: shell

Configures the interactive shell environment.

**Packages:** lazygit, fzf

**Features:**
- Starship (cross-shell prompt)
- Zellij (terminal multiplexer)
- Zoxide (smart cd)
- FZF (fuzzy finder)
- Custom aliases (s., u., g., d., f., lg., e.)
- Session variables (EDITOR, CARGO_HOME, RUSTUP_HOME)

**Config files:** `config/starship/`, `config/zellij/`

---

### Module: custom-dev

Development tools for software engineering.

**Packages:** rustc, cargo, rustup, cmake, vlang, zed-editor

**Features:**
- Rust toolchain
- CMake build system
- V programming language
- Zed code editor

---

### Module: custom-apps

Desktop applications for various tasks.

**Packages:** discord, flatpak, gtk2-engines-murrine, blender, darktable, gimp, bitwarden-desktop, spotify

**Sub-options (enable/disable individually):**
- `custom.apps.discord` - Discord messaging
- `custom.apps.zen-browser` - Zen Browser + GTK theming
- `custom.apps.blender` - 3D graphics
- `custom.apps.darktable` - Photo management
- `custom.apps.gimp` - Image editing
- `custom.apps.bitwarden` - Password manager
- `custom.apps.spotify` - Music streaming

---

### Module: custom-essentials

Essential command-line tools.

**Packages:** buildEssential, git, curl, xclip, nettools, htop

---

## Managing Modules

### Disable a Module

Remove or comment out the import in `home.nix`:

```nix
imports = [
  ./modules/shell/default.nix
  ./modules/programs/custom-dev.nix
  # ./modules/programs/custom-apps.nix  # Disabled
  ./modules/programs/custom-essentials.nix
];
```

### Disable Individual Apps

Keep the module but disable specific apps:

```nix
custom.apps = {
  enable = true;
  discord = false;      # Disable Discord
  blender = false;     # Disable Blender
  # Keep: zen-browser, darktable, gimp
};
```

### Add Packages to a Module

Edit the module file and add to `home.packages`:

```nix
home.packages = with pkgs; [
  pkgs.existing-package
  pkgs.new-package
];
```

### Add a New Module

1. Create `modules/programs/my-module.nix`:

```nix
{ config, pkgs, lib, ... }:

let
  cfg = config.custom.my-module;
in

{
  options.custom.my-module = {
    enable = lib.mkEnableOption "My custom module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.some-package
    ];
  };
}
```

2. Import it in `home.nix`:

```nix
imports = [
  # ... existing imports
  ./modules/programs/my-module.nix
];
```

## Configuration Files (Dotfiles)

Tool configuration files are stored in `config/` and symlinked to `~/.config/`.

### Add a Dotfile

In `home.nix`, add to `home.file`:

```nix
home.file = {
  # Existing files...
  
  # New dotfile
  ".config/mytool/config.toml".source = ./config/mytool/config.toml;
};
```

## Packages Reference

### Core Packages (home.nix)
| Package | Description |
|---------|-------------|
| bottom | System/process monitor |
| fzf | Fuzzy finder |
| git | Version control |
| gnome-shell | GNOME desktop |
| lazygit | Git TUI |
| micro | Terminal editor |
| ripgrep | Fast grep |
| starship | Shell prompt |
| sushi | File previewer |
| zed-editor | Code editor |
| zellij | Terminal multiplexer |
| zoxide | Smart cd |

### Development (custom-dev)
| Package | Description |
|---------|-------------|
| rustc | Rust compiler |
| cargo | Rust package manager |
| rustup | Rust toolchain manager |
| cmake | Build system |
| vlang | V language |
| zed-editor | Code editor |

### Essentials (custom-essentials)
| Package | Description |
|---------|-------------|
| buildEssential | Compiler toolchain |
| git | Version control |
| curl | HTTP client |
| xclip | Clipboard manager |
| nettools | Network utilities |
| htop | Process monitor |

### Apps (custom-apps)
| Package | Description |
|---------|-------------|
| discord | Messaging app |
| flatpak | App sandboxing |
| gtk2-engines-murrine | GTK2 theming |
| blender | 3D graphics |
| darktable | Photo RAW processor |
| gimp | Image editor |
| bitwarden-desktop | Password manager |
| spotify | Music streaming |

## Useful Commands

```bash
# Apply configuration
home-manager switch -f ~/.config/home-manager/home.nix

# Show what would change (dry run)
home-manager expunge -f ~/.config/home-manager/home.nix

# List generations
home-manager generations

# Rollback
home-manager rollback -g <GENERATION>

# List packages
home-manager packages -f ~/.config/home-manager/home.nix

# Search for packages
nix-env -qaP | grep <package>

# Update channels
nix-channel --update
```

## Migration from YADM

| Old (YADM) | New (Home Manager) |
|------------|-------------------|
| `~/.config/yadm/tools/*/install.sh` | Module `home.packages` |
| `~/.config/yadm/startup.sh` | `home.sessionVariables` |
| `~/.config/yadm/alias.sh` | `home.shellAliases` |
| Manual script sourcing | Automatic via imports |
| `~/.config/yadm/dotfiles/` | `home.file` with `.source` |

## Benefits

- **Reproducible**: Same config on any machine
- **Declarative**: State what's wanted, not how to achieve it
- **Modular**: Easy to enable/disable components
- **Version controlled**: Git-tracked configuration
- **Rollback support**: Previous generations preserved
