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
    zen-browser = lib.mkEnableOption "Zen Browser and GTK theming";
    zed-editor = lib.mkEnableOption "Zed editor";
    teamviewer = lib.mkEnableOption "TeamViewer remote desktop";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; lib.concatLists [
      (lib.optionals cfg.zen-browser [ inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default ])
      (lib.optionals cfg.zed-editor [ pkgs.zed-editor ])
      (lib.optionals cfg.teamviewer [ teamviewer ])
    ];

    home.sessionVariables = {
      XDG_CONFIG_HOME = "\${HOME}/.config";
    };
  };
}
