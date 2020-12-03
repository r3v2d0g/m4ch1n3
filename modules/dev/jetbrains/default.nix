{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.jetbrains;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && mcfg.wm.enable && ucfg.wm.enable;

      webstorm = lib.overrideDerivation pkgs.jetbrains.webstorm (_:
        lib.optionalAttrs cfg.webstorm.eap {
          version = "203.5981.31";
          src = pkgs.fetchurl {
            url = "https://download.jetbrains.com/webstorm/WebStorm-203.5981.31.tar.gz";
            sha256 = "2442c2e58c1a8e9ecfd2ccc814b0ada5d399a74359e15837b2bf7892ba32c7e0";
          };
        }
      );
    in {
      options.m4ch1n3.dev.jetbrains = lib.optionalAttrs enable {
        enable = lib.mkOptBool false;

        webstorm.enable = lib.mkOptBool true;
        webstorm.eap = lib.mkOptBool false;
      };

      config.home.packages = lib.optional (enable && cfg.enable && cfg.webstorm.enable) webstorm;
    };
}
