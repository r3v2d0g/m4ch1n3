{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.comm.discord;
      enable = ucfg.comm.enable && cfg.enable;
    in {
      options.m4ch1n3.comm.discord.enable = lib.mkOptBool true;
      config.home.packages = lib.mkIf enable [ pkgs.discord ];
    };
}
