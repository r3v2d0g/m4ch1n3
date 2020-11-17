{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.wm.audio;

    in { options.m4ch1n3.wm.audio =
           lib.optionalAttrs config.m4ch1n3.wm.enable
             { enable = lib.mkDisableOption "audio"; };

         config = lib.mkIf config.m4ch1n3.wm.enable
           { hardware.pulseaudio.enable = cfg.enable; };
       };

  users = { config, lib, mconfig, pkgs, ... }:
    let cfg = config.m4ch1n3.wm.audio;
        enable = mconfig.m4ch1n3.wm.enable
                 && mconfig.m4ch1n3.wm.audio.enable
                 && config.m4ch1n3.wm.enable;

    in { options.m4ch1n3.wm.audio = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "audio"; };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages = [ pkgs.pamixer ]; };
       };
}
