{ config, lib, pkgs, ... }:

let cfg = config.m4ch1n3.users.root;

in { options.m4ch1n3.users.root =
       { enable = lib.mkDisableOption "root"; };

     config = lib.mkIf cfg.enable
       { home-manager.users.root =
           { m4ch1n3.editor.emacs.enable = true; };

         users.users.root.hashedPassword =
            "$6$rounds=100000$.iwGNU2p46IK0Fbo$YlfkQxalWM9vC3iyEhh3hJLv1MhqTF2PoanBenl5IpTENfdih2Y2oc.0xfIywy1MKLPKdDQ43V92cNz2sntfP.";
       };
   }
