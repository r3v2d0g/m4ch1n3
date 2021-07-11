{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.elixir;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.elixir.enable = lib.mkOptBool false;
      config.home.packages = lib.mkIf enable [ pkgs.elixir ];
    };
}
