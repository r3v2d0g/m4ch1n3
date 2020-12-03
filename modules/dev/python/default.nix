{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.python;
      enable = mcfg.dev.enable && ucfg.dev.enable;
    in {
      options.m4ch1n3.dev.python = lib.optionalAttrs enable {
        enable = lib.mkOptBool true;

        package = lib.mkOptPkg pkgs.python38;
        packages = lib.mkOptAny pkgs.python38Packages;
      };

      config.home.packages = lib.mkIf (enable && cfg.enable) [ cfg.package ];
    };
}
