{
  machine = { ... }: {};

  users = { config, lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev.build;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.build = {
        enable = lib.mkOptBool true;

        extraPkgConfigPaths = lib.mkOptStrList [];
      };

      config.home = lib.mkIf enable {
        packages = [
          pkgs.clang
          pkgs.cmake
          pkgs.meson
          pkgs.ninja
          pkgs.pkg-config
        ];

        sessionVariables."LIBCLANG_PATH" = "${pkgs.llvmPackages.libclang.lib}/lib";

        sessionVariables."PKG_CONFIG_PATH" = lib.concatStringsColon ([
          "/run/current-system/sw/lib/pkgconfig"
          "${config.home.profileDirectory}/lib/pkgconfig"
          "$PKG_CONFIG_PATH"
        ] ++ cfg.extraPkgConfigPaths);
      };
    };
}
