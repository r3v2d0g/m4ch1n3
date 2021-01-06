{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.typescript;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.typescript.enable = lib.mkOptBool true;
      config.home.packages = lib.mkIf enable [ pkgs.nodePackages.typescript ];
    };
}
