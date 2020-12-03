{
  machine = { ... }: {};

  users = { mcfg, lib, ucfg, ... }:
    let
      cfg = ucfg.security.gpg;
      wm = mcfg.wm.enable && ucfg.wm.enable;
    in {
      options.m4ch1n3.security.gpg = {
        enable = lib.mkOptBool true;

        agent.enable = lib.mkOptBool false;
        agent.pinentry = lib.mkOptStr (if wm then "gtk2" else "tty");
      };

      config = lib.mkIf cfg.enable {
        programs.gpg = {
          enable = true;

          settings = {
            no-emit-version = true;
            no-comments = true;

            keyid-format = "0xlong";
            with-fingerprint = true;

            list-options = "show-uid-validity";
            verify-options = "show-uid-validity";

            use-agent = cfg.agent.enable;

            personal-cipher-preferences = "AES256";
            personal-digest-preferences = "SHA512 SHA384 SHA256";
            personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";

            default-preference-list = "SHA512 SHA384 SHA256 AES256 ZLIB BZIP2 ZIP Uncompressed";

            cert-digest-algo = "SHA256";
          };
        };

        services.gpg-agent = lib.mkIf cfg.agent.enable {
          enable = true;
          enableScDaemon = true;
          enableSshSupport = true;

          defaultCacheTtl = 60;
          defaultCacheTtlSsh = 60;
          maxCacheTtl = 120;
          maxCacheTtlSsh = 120;

          grabKeyboardAndMouse = true;
          pinentryFlavor = cfg.agent.pinentry;

          extraConfig = ''
            allow-emacs-pinentry
          '';
        };
      };
    };
}
