###############################################################################
# Applications Module
###############################################################################

{ config, pkgs, lib, ... }:

let
  cfg = config.apps;
in

{
  options.apps = {
    enable = lib.mkEnableOption "Desktop applications";
    discord = lib.mkEnableOption "Discord messaging";
    zen-browser = lib.mkEnableOption "Zen Browser and GTK theming";
    blender = lib.mkEnableOption "Blender 3D graphics";
    darktable = lib.mkEnableOption "Darktable photo management";
    gimp = lib.mkEnableOption "GIMP image editor";
    bitwarden = lib.mkEnableOption "Bitwarden password manager";
    spotify = lib.mkEnableOption "Spotify music streaming";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; lib.filter (x: x != null) [
      (lib.mkIf cfg.discord discord)
      (lib.mkIf cfg.zen-browser [ flatpak gtk2-engines-murrine ])
      (lib.mkIf cfg.blender blender)
      (lib.mkIf cfg.darktable darktable)
      (lib.mkIf cfg.gimp gimp)
      (lib.mkIf cfg.bitwarden bitwarden-desktop)
      (lib.mkIf cfg.spotify spotify)
    ];

    home.sessionVariables = {
      XDG_CONFIG_HOME = "\${HOME}/.config";
    };
  };
}
