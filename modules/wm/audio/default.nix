{ machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.wm.audio;
      enable = mcfg.wm.enable && cfg.enable;
    in {
      options.m4ch1n3.wm.audio.enable = lib.mkOptBool true;

      config = lib.mkIf enable { hardware.pulseaudio.enable = true; };
    };

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.wm.audio;
      enable = mcfg.wm.enable && mcfg.wm.audio.enable
               && ucfg.wm.enable
               && cfg.enable;
    in {
      options.m4ch1n3.wm.audio.enable = lib.mkOptBool true;
      config = lib.mkIf enable { home.packages = [ pkgs.pamixer ]; };
    };
}
