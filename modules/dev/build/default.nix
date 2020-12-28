{
  machine = { ... }: {};

  users = { config, lib, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev.build;
      enable = ucfg.dev.enable;
    in {
      options.m4ch1n3.dev.build = lib.optionalAttrs enable {
        enable = lib.mkOptBool true;

        extraPkgConfigPaths = lib.mkOptStrList [];
      };

      config.home = lib.mkIf (enable && cfg.enable) {
        packages = [
          pkgs.cmake
          pkgs.meson
          pkgs.ninja
          pkgs.pkg-config
        ];

        sessionVariables."PKG_CONFIG_PATH" = lib.concatStringsColon ([
          "/run/current-system/sw/lib/pkgconfig"
          "${config.home.profileDirectory}/lib/pkgconfig"
        ] ++ cfg.extraPkgConfigPaths);
      };
    };
}
