{ lib, mcfg, pkgs, ... }:

let
  cfg = mcfg.users.root;
in {
  options.m4ch1n3.users.root = {
    enable = lib.mkOptBool true;

    keys.ssh = lib.mkOptStrList
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWlbkVr1wDQIkEcgXOrBAMBSE+W5UR2uvL4Sj9mMJoc" ];
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.root.m4ch1n3 = {
      comm.enable = false;
      editor.emacs.enable = false;
      wm.enable = false;
    };

    users.users.root = {
      hashedPassword =
        "$6$rounds=100000$.iwGNU2p46IK0Fbo$YlfkQxalWM9vC3iyEhh3hJLv1MhqTF2PoanBenl5IpTENfdih2Y2oc.0xfIywy1MKLPKdDQ43V92cNz2sntfP.";
      openssh.authorizedKeys.keys = cfg.keys.ssh;

      shell = pkgs.zsh;
    };
  };
}
