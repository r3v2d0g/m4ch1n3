{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.cypress;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && mcfg.wm.enable && ucfg.wm.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.cypress.enable = lib.mkOptBool false;

      config = lib.mkIf enable {
        home.packages = [ pkgs.cypress ];

        programs.zsh.sessionVariables = {
          "CYPRESS_INSTALL_BINARY" = 0;
          "CYPRESS_RUN_BINARY" = "${pkgs.cypress}/bin/Cypress";
        };
      };
    };
}
