{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.security.ssh;
    in {
      options.m4ch1n3.security.ssh = {
        server = lib.mkOptBool false;

        addr = lib.mkOptStr null;
        port = lib.mkOptInt 22;
      };

      config.services.openssh = lib.mkIf cfg.server {
        enable = true;

        permitRootLogin = "no";
        listenAddresses = [{ inherit (cfg) addr port; }];
      };
    };

  users = { lib, ucfg, ... }:
    let
      cfg = ucfg.security.ssh;
    in {
      options.m4ch1n3.security.ssh.enable = lib.mkOptBool true;

      config.programs.ssh = lib.mkIf cfg.enable {
        enable = true;

        matchBlocks = {
          "github.com" = {
            user = "git";
            hostname = "github.com";
          };
        };
      };
    };
}
