{
  machine = { lib, mcfg, pkgs, ... }:
    let
      cfg = mcfg.base.net;
    in {
      options.m4ch1n3.base.net = {
        host.name = lib.mkOptStr null;
        host.id = lib.mkOptStr null;

        ipv6 = lib.mkOptBool false;
        dhcp = lib.mkOptBool true;

        interfaces = lib.mkOptStrList [];

        netman = lib.mkOptBool false;
        idevice = lib.mkOptBool false;
      };

      config = {
        networking = {
          hostName = cfg.host.name;
          hostId = cfg.host.id;

          interfaces = lib.genAttrs cfg.interfaces (_: { useDHCP = cfg.dhcp; });

          networkmanager.enable = cfg.netman;
        };

        boot.kernel.sysctl."net.ipv6.conf.enp4s0.disable_ipv6" = !cfg.ipv6;

        environment.systemPackages = lib.optional cfg.idevice pkgs.libimobiledevice;
      };
    };

  users = { ... }: {};
}
