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
      starship
      zellij
      zoxide
      go-task
    ];
  };
}
