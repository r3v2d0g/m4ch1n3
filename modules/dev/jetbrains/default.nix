{ machine = { ... }: {};

  users = { config, lib, mconfig, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.jetbrains;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable;

        webstorm = lib.overrideDerivation
          pkgs.jetbrains.webstorm
          (_: lib.optionalAttrs cfg.webstorm.eap
            { src = pkgs.fetchurl {
                url = "https://download.jetbrains.com/webstorm/WebStorm-203.5981.31.tar.gz";
                sha256 = "2442c2e58c1a8e9ecfd2ccc814b0ada5d399a74359e15837b2bf7892ba32c7e0";
              };
            }
          );

    in { options.m4ch1n3.dev.jetbrains = lib.optionalAttrs enable
           { enable = lib.mkEnableOption "JetBrains tools";

             webstorm.enable = lib.mkDisableOption "WebStorm";
             webstorm.eap = lib.mkEnableOption "EAP";
           };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages =
               lib.optional cfg.webstorm.enable webstorm;
           };
       };
}
