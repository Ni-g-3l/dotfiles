###############################################################################
# Flatpak Applications Module
###############################################################################
# Manages Flatpak applications through Home Manager.
# Uses home.activation to ensure Flatpaks are installed/uninstalled.
###############################################################################

{ config, pkgs, lib, ... }:

let
  cfg = config.flatpak-apps;

  flatpak = "${pkgs.flatpak}/bin/flatpak";

  # Define which flatpak apps to install based on options
  flatpakPackages = lib.concatLists [
    (lib.optionals cfg.blender [ "org.blender.Blender" ])
    (lib.optionals cfg.darktable [ "org.darktable.Darktable" ])
    (lib.optionals cfg.gimp [ "org.gimp.GIMP" ])
    (lib.optionals cfg.discord [ "com.discordapp.Discord" ])
    (lib.optionals cfg.spotify [ "com.spotify.Client" ])
    (lib.optionals cfg.bitwarden [ "com.bitwarden.desktop" ])
  ];

  # Generate bash commands for each flatpak package
  installCmds = lib.concatMapStringsSep "\n" (pkg: ''
    echo "Installing flatpak: ${pkg}"
    if ! /usr/bin/flatpak install --or-update --noninteractive flathub ${pkg}; then
      echo "ERROR: Failed to install ${pkg}"
      echo "Try manually: flatpak install flathub ${pkg}"
    fi
  '') flatpakPackages;

  removeCmds = lib.concatMapStringsSep "\n" (pkg: ''
    if /usr/bin/flatpak list --columns=application | grep -q "^${pkg}$"; then
      echo "Removing flatpak: ${pkg}"
      /usr/bin/flatpak uninstall --noninteractive ${pkg}
    fi
  '') flatpakPackages;
in

{
  options.flatpak-apps = {
    enable = lib.mkEnableOption "Flatpak application management";
    blender = lib.mkEnableOption "Blender 3D graphics";
    darktable = lib.mkEnableOption "Darktable photo management";
    gimp = lib.mkEnableOption "GIMP image editor";
    discord = lib.mkEnableOption "Discord messaging";
    spotify = lib.mkEnableOption "Spotify music streaming";
    bitwarden = lib.mkEnableOption "Bitwarden password manager";
  };

  config = lib.mkIf cfg.enable {
    # Install flatpak package
    home.packages = [ pkgs.flatpak ];

    # Activation to install flatpaks
    home.activation.installFlatpaks = lib.mkIf cfg.enable (
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Check prerequisites
        if [ ! -x /usr/bin/gpg ] && [ ! -x /usr/bin/gpg2 ]; then
          echo "ERROR: gnupg2 is required for Flatpak."
          echo "Please run: sudo apt install gnupg2 fuse3"
          echo "Then re-run: home-manager switch"
          exit 1
        fi

        # Use system flatpak with proper GPG setup
        export PATH="/usr/bin:$PATH"

        # Ensure flathub remote exists
        if ! /usr/bin/flatpak remotes | grep -q "flathub"; then
          echo "Adding Flathub remote..."
          /usr/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        fi

        # Install flatpak packages (fail on error)
        ${installCmds}
      ''
    );

    # Deactivation to remove flatpaks when disabled
    # Note: Automatic removal is disabled to prevent accidental uninstalls on every switch.
    # To remove unused runtimes: flatpak uninstall --unused
  };
}
