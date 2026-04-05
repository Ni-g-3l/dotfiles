###############################################################################
# Applications Module
###############################################################################

{ config, pkgs, lib, inputs, ... }:

let
  cfg = config.apps;
in

{
  options.apps = {
    enable = lib.mkEnableOption "Desktop applications";
    discord = lib.mkEnableOption "Discord messaging";
    zen-browser = lib.mkEnableOption "Zen Browser and GTK theming";
    zed-editor = lib.mkEnableOption "Zed editor";
    blender = lib.mkEnableOption "Blender 3D graphics";
    darktable = lib.mkEnableOption "Darktable photo management";
    gimp = lib.mkEnableOption "GIMP image editor";
    bitwarden = lib.mkEnableOption "Bitwarden password manager";
    spotify = lib.mkEnableOption "Spotify music streaming";
    rio = lib.mkEnableOption "Rio terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; lib.concatLists [
      (lib.optionals cfg.discord [ discord ])
      (lib.optionals cfg.zen-browser [ inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default ])
      (lib.optionals cfg.zed-editor [ pkgs.zed-editor ])
      (lib.optionals cfg.blender [ blender ])
      (lib.optionals cfg.darktable [ darktable ])
      (lib.optionals cfg.gimp [ gimp ])
      (lib.optionals cfg.rio [ rio ])
      (lib.optionals cfg.bitwarden [ bitwarden-desktop ])
      (lib.optionals cfg.spotify [ spotify ])
    ];

    home.sessionVariables = {
      XDG_CONFIG_HOME = "\${HOME}/.config";
    };
  };
}
