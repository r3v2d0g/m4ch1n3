{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.cypress;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && mcfg.wm.enable && ucfg.wm.enable;

      cypress = pkgs.cypress.overrideAttrs (_: {
        version = "6.0.0";
        src = pkgs.fetchurl {
          url = "https://cdn.cypress.io/desktop/6.0.0/linux-x64/cypress.zip";
          sha256 = "1qsp3lc98sl4bcj2g61ydv3q08b9jkqgd1asy9pk31h9r5ribfpa";
        };
      });
    in {
      options.m4ch1n3.dev.cypress = lib.optionalAttrs enable { enable = lib.mkOptBool false; };

      config = lib.mkIf (enable && cfg.enable) {
        home.packages = [ cypress ];

        programs.zsh.sessionVariables = {
          "CYPRESS_INSTALL_BINARY" = 0;
          "CYPRESS_RUN_BINARY" = "${cypress}/bin/Cypress";
        };
      };
    };
}
