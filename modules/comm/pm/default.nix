{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.comm.pm;
      enable = ucfg.comm.enable && cfg.enable;
    in {
      options.m4ch1n3.comm.pm.enable = lib.mkOptBool true;
      config.home.packages = lib.mkIf enable [ pkgs.protonmail-bridge ];
    };
}
