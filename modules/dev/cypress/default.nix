{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.cypress;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && mcfg.wm.enable && ucfg.wm.enable
               && cfg.enable;

      cypress = pkgs.cypress.overrideAttrs (_: {
        version = "6.2.1";
        src = pkgs.fetchurl {
          url = "https://cdn.cypress.io/desktop/6.3.0/linux-x64/cypress.zip";
          sha256 = "0jdlm700l515jhva9rdm9219fv20h1kwzdc1d5k6zvzafpq4fd1s";
        };
      });
    in {
      options.m4ch1n3.dev.cypress.enable = lib.mkOptBool false;

      config = lib.mkIf enable {
        home.packages = [ cypress ];

        programs.zsh.sessionVariables = {
          "CYPRESS_INSTALL_BINARY" = 0;
          "CYPRESS_RUN_BINARY" = "${cypress}/bin/Cypress";
        };
      };
    };
}
