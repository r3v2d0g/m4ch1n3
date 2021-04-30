{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.security.tailscale;
    in {
      options.m4ch1n3.security.tailscale.enable = lib.mkOptBool false;

      config = lib.mkIf cfg.enable {
        boot.kernel.sysctl."net.ipv4.ip_forward" = true;
        boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = true;

        services.tailscale.enable = true;

        networking.firewall = {
          trustedInterfaces = [ "tailscale0" ];
          allowedUDPPorts = [ 41641 ];
        };
      };
    };

  users = { ... }: {};
}
