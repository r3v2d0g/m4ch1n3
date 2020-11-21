{ machine = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.gpg;

    in { options.m4ch1n3.gpg =
           { enable = lib.mkDisableOption "gpg";

             yubikey = lib.mkEnableOption "yubikey support";
           };

         config = lib.mkIf cfg.enable
           { services.udev.packages = lib.mkIf cfg.yubikey
               [ pkgs.libu2f-host
                 pkgs.yubikey-personalization
               ];

             services.pcscd.enable = lib.mkIf cfg.yubikey true;
           };
       };

  users = { config, mconfig, lib, ... }:
    let cfg = config.m4ch1n3.gpg;
        enable = mconfig.m4ch1n3.gpg.enable;

    in { options.m4ch1n3.gpg = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "gpg";

             agent =
               { enable = lib.mkEnableOption "gpg-agent";

                 pinentry = lib.mkStrOption
                   (if mconfig.m4ch1n3.wm.enable && config.m4ch1n3.wm.enable
                    then { default = "gtk2"; }
                    else { default = "tty"; }
                   );
               };
           };

         config = lib.mkIf enable
           { programs.gpg = lib.mkIf cfg.enable
               { enable = true;

                 settings =
                   { no-emit-version = true;
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

             services.gpg-agent = lib.mkIf cfg.agent.enable
               { enable = true;

                 enableScDaemon = true;
                 enableSshSupport = true;

                 defaultCacheTtl = 60;
                 defaultCacheTtlSsh = 60;
                 maxCacheTtl = 120;
                 maxCacheTtlSsh = 120;

                 grabKeyboardAndMouse = true;
                 pinentryFlavor = cfg.agent.pinentry;

                 extraConfig =
                   ''
                      allow-emacs-pinentry
                   '';
               };
           };
       };
}
