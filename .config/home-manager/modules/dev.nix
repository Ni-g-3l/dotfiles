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
    docker = lib.mkEnableOption "Docker and Docker Compose";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
      cmake
      vlang
      hugo
    ] ++ lib.optionals cfg.docker [
      docker
      docker-compose
    ];
  };
}
