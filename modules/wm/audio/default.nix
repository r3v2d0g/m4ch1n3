{ machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.wm.audio;
    in {
      options.m4ch1n3.wm.audio = lib.optionalAttrs mcfg.wm.enable
        { enable = lib.mkOptBool true; };

      config = lib.mkIf mcfg.wm.enable { hardware.pulseaudio.enable = cfg.enable; };
    };

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.wm.audio;
      enable = mcfg.wm.enable && mcfg.wm.audio.enable
               && ucfg.wm.enable;
    in {
      options.m4ch1n3.wm.audio = lib.optionalAttrs enable { enable = lib.mkOptBool true; };
      config = lib.mkIf (enable && cfg.enable) { home.packages = [ pkgs.pamixer ]; };
    };
}
