{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.security.fw;
    in {
      options.m4ch1n3.security.fw = {
        ports = lib.mkOptIntList [];
      };

      config.networking.firewall = {
        allowedTCPPorts = cfg.ports;
      };
    };

  users = { ... }: {};
}
