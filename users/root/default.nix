{ lib, mcfg, pkgs, ... }:

let
  cfg = mcfg.users.root;
in {
  options.m4ch1n3.users.root.enable = lib.mkOptBool true;

  config = lib.mkIf cfg.enable {
    home-manager.users.root.m4ch1n3 = {
      comm.enable = false;
      editor.emacs.enable = true;
      wm.enable = false;
    };

    users.users.root = {
      hashedPassword =
        "$6$rounds=100000$.iwGNU2p46IK0Fbo$YlfkQxalWM9vC3iyEhh3hJLv1MhqTF2PoanBenl5IpTENfdih2Y2oc.0xfIywy1MKLPKdDQ43V92cNz2sntfP.";

      shell = pkgs.zsh;
    };
  };
}
