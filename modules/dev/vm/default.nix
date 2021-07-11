{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.dev.vm;
      enable = mcfg.dev.enable && cfg.enable;
    in {
      options.m4ch1n3.dev.vm.enable = lib.mkOptBool false;

      config.virtualisation.virtualbox.host.enable = lib.mkIf enable true;
    };

  users = { lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev.vm;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && mcfg.dev.vm.enable && cfg.enable;
    in {
      options.m4ch1n3.dev.vm.enable = lib.mkOptBool true;

      config.home.packages = lib.mkIf enable [ pkgs.virtualbox ];
    };
}
