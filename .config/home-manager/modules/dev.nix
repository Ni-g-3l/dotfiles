###############################################################################
# Development Tools Module
###############################################################################

{ config, pkgs, lib, ... }:

let
  cfg = config.dev;
in

{
  options.dev = {
    enable = lib.mkEnableOption "Development tools";
    rio = lib.mkEnableOption "Rio terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.rustc
      pkgs.cargo
      pkgs.rustup
      pkgs.cmake
      pkgs.vlang
      pkgs.zed-editor
      (lib.mkIf cfg.rio [ pkgs.flatpak ])
    ];
  };
}
