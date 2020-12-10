{ lib, mcfg, ... }:

let
  cfg = mcfg.users.eqs;
  enable = mcfg.dev.enable && mcfg.dev.docker.enable;
in {
  options.m4ch1n3.users.eqs = lib.optionalAttrs enable { enable = lib.mkOptBool false; };

  config = lib.mkIf (enable && cfg.enable) {
    home-manager.users.eqs.m4ch1n3 = {
      comm.enable = false;
      dev.docker.enable = true;
      editor.emacs.enable = false;
      security.gpg.enable = false;
      security.ssh.enable = false;
      shell.enable = false;
    };

    users.extraUsers.eqs = {
      uid = 2000;
      group = "users";
      extraGroups = [ "eqs" "docker" ];
    };

    users.extraGroups.eqs.gid = 2000;
  };
}
