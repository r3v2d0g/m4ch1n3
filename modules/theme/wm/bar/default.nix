{ machine = { ... }: {};

  users = { config, lib, mconfig, ... }:
    let cfg = config.m4ch1n3.theme.wm.bar;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.bar.enable;
        colors = mconfig.m4ch1n3.theme.colors;
        fonts = mconfig.m4ch1n3.theme.fonts;

    in { options.m4ch1n3.theme.wm.bar = lib.optionalAttrs enable
           { colors =
               { bar.fg = lib.mkColorOption
                   { default = "fg_alt"; };

                 bar.bg = lib.mkColorOption
                   { default = "bg_alt"; };

                 audio.normal = lib.mkColorOption
                   { default = "fg"; };

                 audio.muted = lib.mkColorOption
                   { default = "fg_alt"; };

                 clock.normal = lib.mkColorOption
                   { default = "fg_alt"; };

                 clock.minute = lib.mkColorOption
                   { default = "base8"; };

                 clock.hour = lib.mkColorOption
                   { default = "fg"; };
               };
           };

         config = lib.mkIf enable
           { programs.waybar.style =
               ''
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
       };
}
