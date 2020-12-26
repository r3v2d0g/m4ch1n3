{
  machine = { lib, ... }: { options.m4ch1n3.dev.enable = lib.mkOptBool false; };

  users = { config, lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev;
      enable = mcfg.dev.enable;
    in {
      options.m4ch1n3.dev = lib.optionalAttrs enable { enable = lib.mkOptBool true; };

      config.home = lib.mkIf (enable && cfg.enable) {
        packages = [
          pkgs.binutils
          pkgs.pkg-config
        ];

        sessionVariables."PKG_CONFIG_PATH" =
          "/run/current-system/sw/lib/pkgconfig:${config.home.profileDirectory}/lib/pkgconfig";
      };
    };
}
