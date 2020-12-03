{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.base.fs;

      fs = dev: type: {
        device = dev;
        fsType = type;
      };

      zfs = dev: fs dev "zfs";
      vfat = dev: fs dev "vfat";
    in {
      options.m4ch1n3.base.fs = {
        pool = lib.mkOptStr "zroot";
        root = lib.mkOptStr "safe/root";
        home = lib.mkOptStr "safe/home";
        nix = lib.mkOptStr "local/nix";
        boot = lib.mkOptStr null;
      };

      config.boot.supportedFilesystems = [ "zfs" ];
      config.fileSystems = {
        "/" = zfs "${cfg.pool}/${cfg.root}";
        "/home" = zfs "${cfg.pool}/${cfg.home}";
        "/nix" = zfs "${cfg.pool}/${cfg.nix}";
        "/boot" = vfat cfg.boot;
      };
    };

  users = { ... }: {};
}
