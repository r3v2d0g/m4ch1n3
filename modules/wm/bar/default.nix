{ machine = { ... }: {};

  users = { config, inputs, lib, mconfig, pkgs, ... }:
    let cfg = config.m4ch1n3.wm.bar;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable;
        colors = mconfig.m4ch1n3.theme.colors;
        theme = config.m4ch1n3.theme.wm.bar;

        clock = pkgs.writeTextFile
          { name = "clock";
            destination = "/bin/clock";
            executable = true;

            text =
              ''
                 #! ${pkgs.zsh}/bin/zsh

                 datetime="$(${pkgs.coreutils}/bin/date +%T)"
                 minutes="''${datetime[4,5]}"
                 seconds="''${datetime[7,8]}"

                 echo $datetime
                 echo

                 [[ $seconds -le 5 || $seconds -ge 55 ]] && (echo -n "m" \
                 && [[ $minutes -le 5 || $minutes -ge 55 ]] && echo -n "h") || true
              '';
          };

    in { options.m4ch1n3.wm.bar = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "bar"; };

         config = lib.mkIf (enable && cfg.enable)
           { programs.waybar =
               { enable = true;

                 settings =
                   [ { layer = "overlay";
                       position = "top";
                       height = 30;

                       gtk-layer-shell = false;

                       modules-left =
                         [
                         ];

                       modules-center =
                         [
                         ];

                       modules-right =
                         [ "network"
                           "pulseaudio"
                           "custom/clock"
                         ];

                       modules =
                         { "custom/clock" =
                             { exec = "${clock}/bin/clock";
                               interval = 1;
                             };

                           "network" =
                             { format = "{ifname}: {ipaddr}";
                               format-disconnected = "{ifname}: disconnected";
                             };

                           "pulseaudio" =
                             { format = "{volume}%   {format_source}";
                               format-muted = "<span fgcolor=\"${colors.${theme.colors.audio.muted}}\">{volume}%</span>   {format_source}";
                               format-source = "{volume}%";
                               format-source-muted = "<span fgcolor=\"${colors.${theme.colors.audio.muted}}\">{volume}%</span>";
                               on-scroll-up = "echo";
                               on-scroll-down = "echo";
                               tooltip = false;
                             };
                         };
                     }
                   ];
               };

             wayland.windowManager.sway.config.bars =
               [ { command = "waybar"; } ];
           };
       };
}
