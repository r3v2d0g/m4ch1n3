{
  machine =  { ... }: {};

  users = { lib, mcfg, ucfg, ... }:
    let
      cfg = ucfg.theme.wm.bar;
      enable = mcfg.wm.enable && ucfg.wm.enable
               && ucfg.wm.bar.enable;
      colors = mcfg.theme.colors;
      fonts = mcfg.theme.fonts;
    in {
      options.m4ch1n3.theme.wm.bar.colors = lib.optionalAttrs enable {
        bar.fg = lib.mkOptColor "fg_alt";
        bar.bg = lib.mkOptColor "bg_alt";

        audio.normal = lib.mkOptColor "fg";
        audio.muted = lib.mkOptColor "fg_alt";

        clock.normal = lib.mkOptColor "fg_alt";
        clock.minute = lib.mkOptColor "base8";
        clock.hour = lib.mkOptColor "fg";
      };

      config.programs.waybar.style = lib.mkIf enable ''
        * {
            min-height: 0;
            margin-left: 5px;
            margin-right: 5px;
            border: none;
            border-radius: 0;
            font-family: ${fonts.default.name};
            font-size: 12px;
            color: ${colors.${cfg.colors.bar.fg}};
        }

        window#waybar {
            border: none;
            background-color: ${colors.${cfg.colors.bar.bg}};
        }

        #pulseaudio {
            margin-left: 15px;
            margin-right: 15px;
            color: ${colors.${cfg.colors.audio.normal}};
        }

        #custom-clock {
            margin-left: 10px;
            color: ${colors.${cfg.colors.clock.normal}};
        }

        #custom-clock.m {
            color: ${colors.${cfg.colors.clock.minute}};
        }

        #custom-clock.mh {
            color: ${colors.${cfg.colors.clock.hour}};
        }
      '';
    };
}
