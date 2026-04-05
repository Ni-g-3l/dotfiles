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
      buildEssential
      git
      curl
      xclip
      nettools
      htop

      # Additional CLI tools
      bottom
      fzf
      lazygit
      micro
      ripgrep
      zellij
      zoxide
      go-task
    ];
  };
}
