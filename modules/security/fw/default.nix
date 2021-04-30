{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.security.fw;
    in {
      options.m4ch1n3.security.fw = {
        ports = {
          tcp = lib.mkOptIntList [];
          udp = lib.mkOptIntList [];
        };
      };

      config.networking.firewall = {
        enable = true;

        allowedTCPPorts = cfg.ports.tcp;
        allowedUDPPorts = cfg.ports.udp;
      };
    };

  users = { ... }: {};
}
