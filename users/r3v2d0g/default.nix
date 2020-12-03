{ lib, pkgs, mcfg, ... }:

let
  cfg = mcfg.users.r3v2d0g;
in {
  options.m4ch1n3.users.r3v2d0g = {
    enable = lib.mkOptBool true;

    name = lib.mkOptStr "Matthieu Le brazidec (r3v2d0g)";
    email = lib.mkOptStr "r3v2d0g@jesus.gg";

    uid = lib.mkOptInt 1;

    wheel = lib.mkOptBool true;
    groups = lib.mkOptStrList [];

    home.path = lib.mkOptStr "/home/r3v2d0g";
    home.create = lib.mkOptBool true;

    password = lib.mkOptEnum [ "local" "remote" ] null;

    keys.git = lib.mkOptStr "0x14D54AAE149D1DC9";
    keys.ssh = lib.mkOptStrList
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWlbkVr1wDQIkEcgXOrBAMBSE+W5UR2uvL4Sj9mMJoc" ];

    comm = {
      enable = lib.mkOptBool false;

      discord = lib.mkOptBool false;
      pm = lib.mkOptBool false;
      slack = lib.mkOptBool false;
    };

    dev = lib.optionalAttrs mcfg.dev.enable {
      enable = lib.mkOptBool true;

      cypress = lib.mkOptBool false;
      docker = lib.mkOptBool true;

      haskell = lib.mkOptBool true;
      nodejs = lib.mkOptBool true;
      python = lib.mkOptBool true;
      rust = lib.mkOptBool true;
      typescript = lib.mkOptBool true;
      vuejs = lib.mkOptBool true;
    };

    wm = lib.optionalAttrs mcfg.wm.enable {
      enable = lib.mkOptBool true;

      autostart = lib.mkOptBool false;

      audio = lib.mkOptBool true;
      browser = lib.mkOptBool true;
      onepassword = lib.mkOptBool true;
      term = lib.mkOptBool true;
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.r3v2d0g = {
      programs.git = {
        userName = cfg.name;
        userEmail = cfg.email;

        signing.key = cfg.keys.git;
        signing.signByDefault = true;
      };

      m4ch1n3.comm = { enable = cfg.comm.enable; }
                     // lib.optionalAttrs cfg.comm.enable {
                       discord.enable = cfg.comm.discord;
                       pm.enable = cfg.comm.pm;
                       slack.enable = cfg.comm.slack;
                     };

      m4ch1n3.dev = lib.mkIf mcfg.dev.enable
        ({ enable = cfg.dev.enable; }
         // lib.optionalAttrs cfg.dev.enable {
           cypress.enable = lib.mkIf (mcfg.wm.enable && cfg.wm.enable) cfg.dev.cypress;
           docker.enable = lib.mkIf mcfg.dev.docker.enable cfg.dev.docker;

           haskell.enable = cfg.dev.haskell;
           nodejs.enable = cfg.dev.nodejs;
           python.enable = cfg.dev.python;
           rust.enable = cfg.dev.rust;
           typescript.enable = cfg.dev.typescript;
           vuejs.enable = cfg.dev.vuejs;
         });

      m4ch1n3.security = {
        gpg.agent.enable = true;
        pass.enable = true;
      };

      m4ch1n3.wm = lib.mkIf mcfg.wm.enable
        ({ enable = cfg.wm.enable; }
         // lib.optionalAttrs cfg.wm.enable {
           autostart.enable = cfg.wm.autostart;

           audio.enable = lib.mkIf mcfg.wm.audio.enable cfg.wm.audio;
           browser.enable = lib.mkIf mcfg.wm.browser.enable cfg.wm.browser;
           onepassword.enable = cfg.wm.onepassword;
           term.enable = cfg.wm.term;
         });
    };

    users.extraUsers.r3v2d0g = {
      description = cfg.name;

      uid = cfg.uid;

      group = "users";
      extraGroups = cfg.groups
                    ++ lib.optional cfg.wheel "wheel"
                    ++ lib.optional (mcfg.dev.enable && mcfg.dev.docker.enable
                                     && cfg.dev.docker) "docker";

      home = cfg.home.path;
      createHome = cfg.home.create;

      hashedPassword =
        if cfg.password == "local" then
          "$6$rounds=100000$oIBVnrx1.haJBM$uaaQQMmQ/i0Fums1lPZEmdZnxTrkz9M3sOziOY08XUBeil0v5G8k6qJ.jcIgBSY7Azf7KAdAHHR3WG3jSIqy5."
        else
          if cfg.password == "remote" then
            "$6$rounds=100000$9u6AJvu8NJRMh9qI$77PgODhqPiuy2mnFsW7rzh7d1Ahj5cbqummDlhb9M8p7NuI1bKx4KRPN1RgVJlZ.gaE1tcG/CTRSjuTrbrEW/1"
          else "";

      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = cfg.keys.ssh;
    };

    m4ch1n3.wm.browser.extensions = lib.mkIf (mcfg.wm.enable && cfg.wm.enable) [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm;https://clients2.google.com/service/update2/crx" # uBlock Origin
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
}
