{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev.aws;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.aws.enable = lib.mkOptBool true;

      config.home.packages = lib.mkIf enable [ pkgs.awscli2 ];
    };
}
