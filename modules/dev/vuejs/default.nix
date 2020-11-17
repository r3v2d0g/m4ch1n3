{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.vuejs;

    in { options.m4ch1n3.dev.vuejs =
           { enable = lib.mkDisableOption "vuejs"; };

         config.home.packages = lib.mkIf cfg.enable
           [ pkgs.nodePackages.vue-cli ];
       };
}
