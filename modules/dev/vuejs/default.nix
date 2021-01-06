{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.vuejs;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.vuejs.enable = lib.mkOptBool true;
      config.home.packages = lib.mkIf enable [ pkgs.nodePackages.vue-cli ];
    };
}
