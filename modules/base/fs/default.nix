{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.base.fs;

    in { options.m4ch1n3.base.fs =
           { boot = lib.mkStrOption {};

             pool = lib.mkStrOption
               { default = "zroot"; };

             root = lib.mkStrOption
               { default = "safe/root"; };

             nix = lib.mkStrOption
               { default = "local/nix"; };

             home = lib.mkStrOption
               { default = "safe/home"; };
           };

         config =
           { boot.supportedFilesystems = [ "zfs" ];

             fileSystems."/" =
               { device = "${cfg.pool}/${cfg.root}";
                 fsType = "zfs";
               };

             fileSystems."/boot" =
               { device = cfg.boot;
                 fsType = "vfat";
               };

             fileSystems."/home" =
               { device = "${cfg.pool}/${cfg.home}";
                 fsType = "zfs";
               };

             fileSystems."/nix" =
               { device = "${cfg.pool}/${cfg.nix}"; 
                 fsType = "zfs";
               };
           };
       };

  users = { ... }: {};
}
