{
  machine = { inputs, lib, mcfg, pkgs, ... }:
    let
      cfg = mcfg.wm;
    in {
      options.m4ch1n3.wm = {
        enable = lib.mkOptBool false;

        primary = lib.mkOptStrNull null;
        outputs = lib.mkOptSubmodAttrs {
          rotation = lib.mkOptInt 0;

          resolution.width = lib.mkOptIntNull null;
          resolution.height = lib.mkOptIntNull null;

          position.x = lib.mkOptIntNull null;
          position.y = lib.mkOptIntNull null;
        } {};
      };

      config = lib.mkIf cfg.enable {
        hardware.opengl = {
          enable = true;

          extraPackages = [
            pkgs.intel-media-driver
            pkgs.vaapiIntel
            pkgs.vaapiVdpau
            pkgs.libvdpau-va-gl
          ];

          driSupport = true;
          driSupport32Bit = true;
        };

        environment.systemPackages = [
          pkgs.gnome3.dconf
          pkgs.qt5.qtwayland
        ];

        services.pipewire.enable = true;
        xdg.portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
        };
      };
    };

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.wm;
      wmcfg = mcfg.wm;
      enable = wmcfg.enable && cfg.enable;

      primaryOutput =
        if (isNull wmcfg.primary)
        then null
        else (rec {
          name = wmcfg.primary;

          inherit (wmcfg.outputs."${wmcfg.primary}") resolution position;

          center = {
            x = resolution.width / 2 + position.x;
            y = resolution.height / 2 + position.y;
          };
        });

      workspace = pkgs.writeTextFile {
        name = "workspace";
        destination = "/bin/workspace";
        executable = true;

        text = ''
          #! ${pkgs.zsh}/bin/zsh

          all=$(swaymsg -t get_workspaces \
            | ${pkgs.jq}/bin/jq 'map({num, focused, representation, output}) | sort_by(.num)')
          output=$(echo $all | ${pkgs.jq}/bin/jq -r 'map(select(.focused).output)[]')

          case $2 in
          "next")
              workspace=($(echo $all | jq "map(select(.output == \"$output\"))[-1][]"))
              ;;
          "prev")
              workspace=($(echo $all | jq "map(select(.output == \"$output\"))[0][]"))
              ;;
          *)
              exit 1
          esac

          if [[ ''${workspace[2]} == "true" && ''${workspace[3]} != "null" ]]; then
              num=$(( $(echo $all | jq -r '.[-1].num') + 1 ))

              case $1 in
              "focus")
                  swaymsg workspace $num
                  ;;
              "move")
                  swaymsg move workspace $num
                  ;;
              *)
                  exit 1
              esac
          else
              case "$1 $2" in
              "focus next")
                  swaymsg workspace next_on_output
                  ;;
              "focus prev")
                  swaymsg workspace prev_on_output
                  ;;
              "move next")
                  swaymsg move workspace next_on_output
                  ;;
              "move prev")
                  swaymsg move workspace prev_on_output
                  ;;
              *)
                  exit 1
              esac
          fi
        '';
      };

      sysmon = pkgs.writeTextFile {
        name = "sysmon";
        destination = "/bin/sysmon";
        executable = true;

        text = ''
          #! ${pkgs.zsh}/bin/zsh

          if [ -z "$(swaymsg --type get_tree | grep 'sysmon')" ]; then
              swaymsg -- exec kitty --class=sysmon ${pkgs.bottom}/bin/btm -ag

              for i in {0..10}; do
                  swaymsg "[app_id=sysmon] move to scratchpad" && break
                  sleep 0.1
              done
          fi

          swaymsg -- '[app_id=sysmon]' scratchpad show
        '';
      };
    in {
      options.m4ch1n3.wm = {
        enable = lib.mkOptBool false;

        autostart = {
          enable = lib.mkOptBool false;
          tty = lib.mkOptStr "/dev/tty1";
        };

        mod = lib.mkOptStr "Mod4";
      };

      config = lib.mkIf enable {
        home.packages = [
          pkgs.light
          pkgs.sway-contrib.grimshot
        ];

        gtk = {
          enable = true;

          font = mcfg.theme.fonts.default;

          theme.name = "Adapta-Nokto";
          theme.package = pkgs.adapta-gtk-theme;

          iconTheme.name = "Paper";
          iconTheme.package = pkgs.paper-icon-theme;
        };

        qt.platformTheme = "gtk";

        programs.bash.profileExtra = lib.mkIf cfg.autostart.enable ''
          if [[ -z $DEVICE ]] && [[ $(tty) = ${cfg.autostart.tty} ]]; then
              exec sway
          fi
        '';

        programs.zsh.loginExtra = lib.mkIf cfg.autostart.enable ''
          if [[ -z $DEVICE ]] && [[ $(tty) = ${cfg.autostart.tty} ]]; then
              exec sway
          fi
        '';

        wayland.windowManager.sway = {
          enable = true;

          xwayland = true;
          systemdIntegration = true;

          wrapperFeatures.base = true;
          wrapperFeatures.gtk = true;

          extraSessionCommands = ''
            export SDL_VIDEODRIVER=wayland
            export QT_QPA_PLATFORM=wayland
            export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
            export _JAVA_AWT_WM_NONREPARENTING=1
            export XDG_SESSION_TYPE=wayland
            export XDG_CURRENT_DESKTOP=sway
          '';

          config.input."*".xkb_options = "compose:ralt";

          config.output = lib.mapAttrs (_: { rotation, resolution, position, ... }:
            lib.optionalAttrs (rotation != 0) { transform = toString rotation; }
            // lib.optionalAttrs (! isNull resolution.width && ! isNull resolution.height)
              { resolution = "${toString resolution.width}x${toString resolution.height}"; }
            // lib.optionalAttrs (! isNull position.x && ! isNull position.y)
              { position = "${toString position.x} ${toString position.y}"; }
          ) wmcfg.outputs;

          config.focus.followMouse = false;
          config.focus.forceWrapping = false;
          config.focus.mouseWarping = false;
          config.focus.newWindow = "none";

          config.floating.modifier = cfg.mod;
          config.keybindings = {
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

            "${cfg.mod}+Ctrl+Mod1+h" = "resize grow width";
            "${cfg.mod}+Ctrl+Mod1+k" = "resize grow height";
            "${cfg.mod}+Ctrl+Mod1+j" = "resize shrink height";
            "${cfg.mod}+Ctrl+Mod1+l" = "resize shrink width";

            "${cfg.mod}+Ctrl+h" = "exec ${workspace}/bin/workspace focus prev";
            "${cfg.mod}+Ctrl+l" = "exec ${workspace}/bin/workspace focus next";

            "${cfg.mod}+Ctrl+Shift+h" = "exec ${workspace}/bin/workspace move prev";
            "${cfg.mod}+Ctrl+Shift+l" = "exec ${workspace}/bin/workspace move next";

            "${cfg.mod}+Return"       = "focus mode_toggle";
            "${cfg.mod}+Shift+Return" = "floating toggle";

            "${cfg.mod}+f" = "fullscreen toggle";

            "${cfg.mod}+d" = "layout default";
            "${cfg.mod}+s" = "layout stacking";
            "${cfg.mod}+t" = "layout tabbed";

            "${cfg.mod}+Shift+v" = "split vertical";
            "${cfg.mod}+Shift+b" = "split horizontal";

            "${cfg.mod}+Shift+q" = "kill";
            "${cfg.mod}+Mod1+r"  = "reload";
            "${cfg.mod}+Mod1+e"  = "exit";
          }
          // lib.optionalAttrs cfg.bar.enable
            { "${cfg.mod}+Shift+Escape" = "exec pkill -SIGUSR1 waybar"; }
          // lib.optionalAttrs cfg.term.enable {
            "${cfg.mod}+q"   = "exec kitty";
            "Ctrl+Mod1+Home" = "exec ${sysmon}/bin/sysmon";
          }
          // lib.optionalAttrs ucfg.editor.emacs.enable { "${cfg.mod}+e" = "exec emacs"; }
          // lib.optionalAttrs cfg.browser.enable { "${cfg.mod}+c" = "exec chromium"; }
          // lib.optionalAttrs cfg.onepassword.enable { "${cfg.mod}+1" = "exec 1password"; }
          // lib.optionalAttrs (ucfg.comm.enable && ucfg.comm.discord.enable)
            { "${cfg.mod}+Shift+d" = "exec Discord"; }
          // lib.optionalAttrs (ucfg.comm.enable && ucfg.comm.slack.enable)
            { "${cfg.mod}+Shift+s" = "exec slack"; }
          // lib.optionalAttrs cfg.audio.enable {
            "XF86AudioMute"        = "exec pamixer -t";
            "XF86AudioRaiseVolume" = "exec pamixer -i 5";
            "XF86AudioLowerVolume" = "exec pamixer -d 5";

            "${cfg.mod}+m"    = "exec pamixer -t";
            "${cfg.mod}+up"   = "exec pamixer -i 5";
            "${cfg.mod}+down" = "exec pamixer -d 5";

            "${cfg.mod}+Shift+m"    = "exec pamixer --default-source -t";
            "${cfg.mod}+Shift+up"   = "exec pamixer --default-source -i 5";
            "${cfg.mod}+Shift+down" = "exec pamixer --default-source -d 5";
          };

          extraConfig = ''
            seat * hide_cursor 5000

            for_window [app_id="kitty"] border pixel 2
            for_window [class="Emacs"] border pixel 2

            ${lib.optionalString (! isNull primaryOutput) ''
              exec_always swaymsg focus output ${primaryOutput.name} && \
                            swaymsg seat seat0 cursor set \
                            ${toString primaryOutput.center.x} \
                            ${toString primaryOutput.center.y}
            ''}

            ${lib.optionalString cfg.bar.enable ''
              bindsym --no-repeat ${cfg.mod}+Escape exec pkill -SIGUSR1 waybar
              bindsym --release ${cfg.mod}+Escape exec pkill -SIGUSR1 waybar
            ''}
          '';
        };
      };
    };
}
