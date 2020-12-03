{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.comm.slack;
      enable = ucfg.comm.enable;
    in {
      options.m4ch1n3.comm.slack = lib.optionalAttrs enable { enable = lib.mkOptBool true; };
      config.home.packages = lib.mkIf (enable && cfg.enable) [ pkgs.slack ];
    };
}
