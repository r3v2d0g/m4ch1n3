{
  machine = { lib, mcfg, pkgs, ... }:
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
        efi = lib.mkOptStrNull null;
      };

      config = {
        boot.loader.efi.efiSysMountPoint = lib.mkIf (! isNull cfg.efi) "/efi";
        boot.supportedFilesystems = [ "zfs" ];
        fileSystems = {
          "/" = zfs "${cfg.pool}/${cfg.root}";
          "/home" = zfs "${cfg.pool}/${cfg.home}";
          "/nix" = zfs "${cfg.pool}/${cfg.nix}";

          "/efi" = lib.mkIf (! isNull cfg.efi) (vfat cfg.efi);
          "/boot" = if (isNull cfg.efi)
                    then (vfat cfg.boot)
                    else (zfs cfg.boot);
        };

        environment.systemPackages = [ pkgs.fuse3 ];
      };
    };

  users = { ... }: {};
}
