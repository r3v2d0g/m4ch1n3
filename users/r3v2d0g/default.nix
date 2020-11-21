{ config, lib, pkgs, ... }:

let cfg = config.m4ch1n3.users.r3v2d0g;
    mcfg = config.m4ch1n3;

in { options.m4ch1n3.users.r3v2d0g =
       { enable = lib.mkEnableOption "r3v2d0g";

         name = lib.mkStrOption
           { default = "Matthieu Le brazidec (r3v2d0g)"; };

         email = lib.mkStrOption
           { default = "r3v2d0g@jesus.gg"; };

         uid = lib.mkIntOption
           { default = 1; };

         wheel = lib.mkDisableOption "wheel group";

         groups = lib.mkListOfStrOption
           { default = []; };

         home.path = lib.mkStrOption
           { default = "/home/r3v2d0g"; };

         home.create = lib.mkDisableOption "create home directory";

         password = lib.mkEnumOption [ "local" "remote" ] {};

         keys.ssh = lib.mkListOfStrOption
           { default =
               [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWlbkVr1wDQIkEcgXOrBAMBSE+W5UR2uvL4Sj9mMJoc" ];
           };

         keys.git = lib.mkStrOption
           { default = "0x14D54AAE149D1DC9"; };

         comm = { enable = lib.mkEnableOption "communication"; };

         security.pass =
           { enable = lib.mkEnableOption "password-store"; };

         wm = lib.optionalAttrs mcfg.wm.enable
           { enable = lib.mkDisableOption "window manager";

             autostart =
               { enable = lib.mkEnableOption "autostart";

                 tty = lib.mkStrOption
                   { default = "/dev/tty1"; };
               };

             audio = lib.optionalAttrs mcfg.wm.audio.enable
               { enable = lib.mkDisableOption "audio"; };

             browser = lib.optionalAttrs mcfg.wm.browser.enable
               { enable = lib.mkDisableOption "web browser"; };

             onepassword = { enable = lib.mkEnableOption "1password"; };

             term = { enable = lib.mkDisableOption "terminal"; };
           };
       };

     config = lib.mkIf cfg.enable
       { home-manager.users.r3v2d0g =
           { m4ch1n3.editor.emacs =
               { enable = true;

                 #config =
                 #  { user.name = cfg.name;
                 #    user.email = cfg.email;

                 #    setq =
                 #      { "auth-sources" =
                 #          ''
                 #             '("~/.autoinfo.gpg")
                 #          '';

                 #        "lsp-enable-semantic-highlighting" = "t";
                 #        # TODO: "lsp-rust-analyzer-cargo-watch-command" = ''"clippy"'';
                 #        "lsp-rust-analyzer-server-display-inlay-hints" = "t";
                 #        "lsp-rust-analyzer-display-parameter-hints" = "t";
                 #        "lsp-rust-analyzer-display-chaining-hints" = "t";

                 #        "rustic-lsp-server" = "'rust-analyzer";
                 #        "rustic-match-angle-brackets" = "nil";
                 #      };
                 #  };
               };

             m4ch1n3.gpg.agent.enable = true;

             m4ch1n3.comm.enable = cfg.comm.enable;

             m4ch1n3.security.pass.enable = cfg.security.pass.enable;

             m4ch1n3.wm = lib.mkIf (mcfg.wm.enable && cfg.wm.enable)
               { enable = true;

                 autostart.enable = cfg.wm.autostart.enable;
                 autostart.tty = cfg.wm.autostart.tty;

                 audio = lib.mkIf mcfg.wm.audio.enable
                   { enable = cfg.wm.audio.enable; };

                 browser = lib.mkIf mcfg.wm.browser.enable
                   { enable = cfg.wm.browser.enable; };

                 onepassword.enable = cfg.wm.onepassword.enable;
                 term.enable = cfg.wm.term.enable;
               };

             programs.git =
               { userName = cfg.name;
                 userEmail = cfg.email;

                 signing.key = cfg.keys.git;
                 signing.signByDefault = true;
               };
           };

         m4ch1n3.wm = lib.mkIf (mcfg.wm.enable && cfg.wm.enable)
           { browser.extensions = lib.mkIf (mcfg.wm.browser.enable)
               [ "cjpalhdlnbpafiamejdnhcphjbkeiagm;https://clients2.google.com/service/update2/crx" # uBlock Origin
                 "ogfcmafjalglgifnmanfmnieipoejdcf;https://clients2.google.com/service/update2/crx" # uMatrix
                 "doojmbjmlfjjnbmnoijecmcbfeoakpjm;https://clients2.google.com/service/update2/crx" # NoScript
                 "aeblfdkhhhdcdjpifhhbdiojplfjncoa;https://clients2.google.com/service/update2/crx" # 1Password X
                 "bigefpfhnfcobdlfbedofhhaibnlghod;https://clients2.google.com/service/update2/crx" # MEGA
                 "ennpfpdlaclocpomkiablnmbppdnlhoh;https://clients2.google.com/service/update2/crx" # Rust Search Extension
                 "npeicpdbkakmehahjeeohfdhnlpdklia;https://clients2.google.com/service/update2/crx" # WebRTC Network Limiter
                 "nkgllhigpcljnhoakjkgaieabnkmgdkb;https://clients2.google.com/service/update2/crx" # Don't Fuck With Paste
                 "godiecgffnchndlihlpaajjcplehddca;https://clients2.google.com/service/update2/crx" # GhostText
               ];
           };

         users.extraUsers.r3v2d0g =
           { description = cfg.name;

             uid = cfg.uid;
             group = "users";
             extraGroups = cfg.groups
                           ++ lib.optional cfg.wheel "wheel";

             home = cfg.home.path;
             createHome = cfg.home.create;

             hashedPassword =
               if cfg.password == "local"
               then "$6$rounds=100000$oIBVnrx1.haJBM$uaaQQMmQ/i0Fums1lPZEmdZnxTrkz9M3sOziOY08XUBeil0v5G8k6qJ.jcIgBSY7Azf7KAdAHHR3WG3jSIqy5."
               else if cfg.password == "remote"
               then "$6$rounds=100000$9u6AJvu8NJRMh9qI$77PgODhqPiuy2mnFsW7rzh7d1Ahj5cbqummDlhb9M8p7NuI1bKx4KRPN1RgVJlZ.gaE1tcG/CTRSjuTrbrEW/1"
               else "";

             openssh.authorizedKeys.keys = cfg.keys.ssh;
           };
       };
   }
