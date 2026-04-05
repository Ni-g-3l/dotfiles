###############################################################################
# Essential Tools Module
###############################################################################

{ config, pkgs, lib, ... }:

let
  cfg = config.essentials;
in

{
  options.essentials = {
    enable = lib.mkEnableOption "Essential command-line tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.buildEssential
      pkgs.git
      pkgs.curl
      pkgs.xclip
      pkgs.nettools
      pkgs.htop
    ];
  };
}
