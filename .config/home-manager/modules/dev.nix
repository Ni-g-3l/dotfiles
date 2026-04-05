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
    docker = lib.mkEnableOption "Docker and Docker Compose";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.rustc
      pkgs.cargo
      pkgs.rustup
      pkgs.cmake
      pkgs.vlang
      pkgs.zed-editor
    ] ++ lib.optionals cfg.rio [
      pkgs.rio
    ] ++ lib.optionals cfg.docker [
      pkgs.docker
      pkgs.docker-compose
    ];
  };
}
