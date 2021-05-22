{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.julia;
      enable = mcfg.dev.enable && ucfg.dev.enable
        && cfg.enable;
    in {
      options.m4ch1n3.dev.julia.enable = lib.mkOptBool false;
      config.home.packages = lib.mkIf enable [ pkgs.julia ];
    };
}
