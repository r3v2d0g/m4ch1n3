{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.base.net;

    in { options.m4ch1n3.base.net =
           { host.name = lib.mkStrOption {};
             host.id = lib.mkStrOption {};

             ipv6 = lib.mkEnableOption "ipv6 support";
             dhcp = lib.mkDisableOption "dhcp support";

             interfaces = lib.mkListOfStrOption
               { default = []; };
           };

         config =
           { networking =
               { hostName = cfg.host.name;
                 hostId = cfg.host.id;

                 enableIPv6 = cfg.ipv6;

                 interfaces = lib.genAttrs
                   cfg.interfaces
                   (_: { useDHCP = cfg.dhcp; });
               };
           };
       };

  users = { ... }: {};
}
