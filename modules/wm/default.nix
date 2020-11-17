{ machine = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.wm;

    in { options.m4ch1n3.wm =
           { enable = lib.mkEnableOption "window manager";

             primary = lib.mkNullOrStrOption
               { default = null; };

             outputs = lib.mkAttrsOfSubmoduleOption {}
               { rotation = lib.mkIntOption
                   { default = 0; };

                 resolution =
                   { width = lib.mkNullOrIntOption
                       { default = null; };

                     height = lib.mkNullOrIntOption
                       { default = null; };
                   };

                 position =
                   { x = lib.mkNullOrIntOption
                       { default = null; };

                     y = lib.mkNullOrIntOption
                       { default = null; };
                   };
               };
           };

         config = lib.mkIf cfg.enable
           { hardware.opengl.enable = true;

             environment.systemPackages =
               [ pkgs.gnome3.dconf
                 pkgs.qt5.qtwayland
               ];
           };
       };

  users = { config, lib, mconfig, pkgs, ... }:
    let cfg = config.m4ch1n3.wm;
        mcfg = mconfig.m4ch1n3.wm;

    in { options.m4ch1n3.wm = lib.optionalAttrs mcfg.enable
           { enable = lib.mkEnableOption "window manager";

             autostart =
               { enable = lib.mkEnableOption "autostart";

                 tty = lib.mkStrOption
                   { default = "/dev/tty1"; };
               };

             mod = lib.mkStrOption
               { default = "Mod4"; };
           };

         config =
           lib.mkIf (mcfg.enable && cfg.enable)
             { gtk =
                 { enable = true;

                   font = mconfig.m4ch1n3.theme.fonts.default;

                   theme =
                     { name = "Adapta-Nokto";
                       package = pkgs.adapta-gtk-theme;
                     };

                   iconTheme =
                     { name = "Paper";
                       package = pkgs.paper-icon-theme;
                     };
                 };

               qt.platformTheme = "gtk";

               programs.bash = lib.mkIf cfg.autostart.enable
                 { profileExtra =
                     ''
                        if [[ -z $DEVICE ]] && [[ $(tty) = ${cfg.autostart.tty} ]]; then
                            exec sway
                        fi
                     '';
                 };

               programs.zsh = lib.mkIf cfg.autostart.enable
                 { profileExtra =
                     ''
                        if [[ -z $DEVICE ]] && [[ $(tty) = ${cfg.autostart.tty} ]]; then
                            exec sway
                        fi
                     '';
                 };

               wayland.windowManager.sway =
                 { enable = true;

                   xwayland = true;
                   systemdIntegration = true;

                   wrapperFeatures.base = true;
                   wrapperFeatures.gtk = true;

                   extraSessionCommands =
                     ''
                        export SDL_VIDEODRIVER=wayland
                        export QT_QPA_PLATFORM=wayland
                        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
                        export _JAVA_AWT_WM_NONREPARENTING=1
                     '';

                   config.input."*".xkb_options = "compose:ralt";

                   config.output = lib.mapAttrs
                     (_: { rotation, resolution, position, ... }:
                       lib.optionalAttrs (rotation != 0)
                         { transform = toString rotation; }
                       // lib.optionalAttrs
                         (! isNull resolution.width && ! isNull resolution.height)
                         { resolution = "${toString resolution.width}x${toString resolution.height}"; }
                       // lib.optionalAttrs
                         (! isNull position.x && ! isNull position.y)
                         { position = "${toString position.x} ${toString position.y}"; }
                     ) mcfg.outputs;

                   config.focus.followMouse = false;
                   config.focus.forceWrapping = false;
                   config.focus.mouseWarping = false;
                   config.focus.newWindow = "none";

                   config.floating.modifier = cfg.mod;
                   config.keybindings =
                     { "${cfg.mod}+Tab"       = "workspace next_on_output";
                       "${cfg.mod}+Shift+Tab" = "workspace prev_on_output";

                       "${cfg.mod}+h" = "focus left";
                       "${cfg.mod}+j" = "focus down";
                       "${cfg.mod}+k" = "focus up";
                       "${cfg.mod}+l" = "focus right";

                       "${cfg.mod}+o" = "focus child";
                       "${cfg.mod}+p" = "focus parent";

                       "${cfg.mod}+Shift+h" = "move left";
                       "${cfg.mod}+Shift+j" = "move down";
                       "${cfg.mod}+Shift+k" = "move up";
                       "${cfg.mod}+Shift+l" = "move right";

                       "${cfg.mod}+Mod1+h" = "focus output left";
                       "${cfg.mod}+Mod1+j" = "focus output down";
                       "${cfg.mod}+Mod1+k" = "focus output up";
                       "${cfg.mod}+Mod1+l" = "focus output right";

                       "${cfg.mod}+Mod1+Shift+h" = "move output left";
                       "${cfg.mod}+Mod1+Shift+j" = "move output down";
                       "${cfg.mod}+Mod1+Shift+k" = "move output up";
                       "${cfg.mod}+Mod1+Shift+l" = "move output right";

                       "${cfg.mod}+Return"       = "focus mode_toggle";
                       "${cfg.mod}+Shift+Return" = "floating toggle";

                       "${cfg.mod}+f" = "fullscreen toggle";

                       "${cfg.mod}+d" = "layout default";
                       "${cfg.mod}+s" = "layout stacking";
                       "${cfg.mod}+t" = "layout tabbed";

                       "${cfg.mod}+Shift+v" = "split vertical";
                       "${cfg.mod}+Shift+b" = "split horizontal";

                       "${cfg.mod}+Shift+q" = "kill";
                       "${cfg.mod}+Mod1+e"  = "exit";
                     } // lib.optionalAttrs cfg.bar.enable
                         { "${cfg.mod}+Shift+Escape" = "exec pkill -SIGUSR1 waybar"; }
                       // lib.optionalAttrs cfg.term.enable
                         { "${cfg.mod}+q" = "exec kitty"; }
                       // lib.optionalAttrs config.m4ch1n3.editor.emacs.enable
                         { "${cfg.mod}+e" = "exec emacs"; }
                       // lib.optionalAttrs cfg.browser.enable
                         { "${cfg.mod}+c" = "exec chromium"; }
                       // lib.optionalAttrs cfg.onepassword.enable
                         { "${cfg.mod}+1" = "exec 1password"; }
                       // lib.optionalAttrs cfg.audio.enable
                         { "XF86AudioMute"        = "exec pamixer -t";
                           "XF86AudioRaiseVolume" = "exec pamixer -i 5";
                           "XF86AudioLowerVolume" = "exec pamixer -d 5";

                           "${cfg.mod}+m"    = "exec pamixer -t";
                           "${cfg.mod}+up"   = "exec pamixer -i 5";
                           "${cfg.mod}+down" = "exec pamixer -d 5";

                           "${cfg.mod}+Shift+m"    = "exec pamixer --default-source -t";
                           "${cfg.mod}+Shift+up"   = "exec pamixer --default-source -i 5";
                           "${cfg.mod}+Shift+down" = "exec pamixer --default-source -d 5";
                         };

                   config.startup = lib.optional (! isNull mcfg.primary)
                     { command = "swaymsg focus output ${mcfg.primary}"; };

                   extraConfig =
                     ''
                        seat * hide_cursor 5000

                        for_window [app_id="kitty"] border pixel 2
                        for_window [class="Emacs"] border pixel 2

                        ${lib.optionalString cfg.bar.enable
                          ''
                             bindsym --no-repeat ${cfg.mod}+Escape exec pkill -SIGUSR1 way
                             bindsym --release ${cfg.mod}+Escape exec pkill -SIGUSR1 way
                          ''
                        }
                     '';
                 };
             };
       };
}
