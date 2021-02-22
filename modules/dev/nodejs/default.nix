{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.nodejs;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;

      nodejs = pkgs.nodejs-15_x;
      yarn = pkgs.yarn.overrideAttrs (_: { buildInputs = [ nodejs ]; });
    in {
      options.m4ch1n3.dev.nodejs.enable = lib.mkOptBool true;
      config.home.packages = lib.mkIf enable [
        nodejs
        yarn
      ];
    };
}
