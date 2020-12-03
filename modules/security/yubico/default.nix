{
  machine = { lib, mcfg, pkgs, ... }:
    let
      cfg = mcfg.security.yubico;
    in {
      options.m4ch1n3.security.yubico.enable = lib.mkOptBool false;

      config = lib.mkIf cfg.enable {
        services = {
          udev.packages = [
            pkgs.libu2f-host
            pkgs.yubikey-personalization
          ];

          pcscd.enable = true;
        };

        security.pam.yubico = {
          enable = true;
          mode = "challenge-response";
        };
      };
    };

  users = { ... }: {};
}
