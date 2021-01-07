{ machine = { ... }: {};

  users = { inputs, lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.wm.bar;
      enable = mcfg.wm.enable && ucfg.wm.enable
               && cfg.enable;

      colors = mcfg.theme.colors;
      theme = ucfg.theme.wm.bar;

      clock = pkgs.writeTextFile {
        name = "clock";
        destination = "/bin/clock";
        executable = true;

        text = ''
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
    in {
      options.m4ch1n3.wm.bar.enable = lib.mkOptBool true;

      config = lib.mkIf enable {
        programs.waybar = {
          enable = true;

          settings = [{
            layer = "overlay";
            position = "top";
            height = 30;

            gtk-layer-shell = false;

            modules-left = [];
            modules-center = [];
            modules-right = [ "network" "pulseaudio" "custom/clock" ];

            modules = {
              "custom/clock" = {
                exec = "${clock}/bin/clock";
                interval = 1;
                tooltip = false;
              };

              "network" = {
                format = "{ifname}: {ipaddr}";
                format-disconnected = "{ifname}: disconnected";
                tooltip = false;
              };

              "pulseaudio" = {
                format = "{volume}%   {format_source}";
                format-muted = "<span fgcolor=\"${colors.${theme.colors.audio.muted}}\">{volume}%</span>   {format_source}";
                format-source = "{volume}%";
                format-source-muted = "<span fgcolor=\"${colors.${theme.colors.audio.muted}}\">{volume}%</span>";
                on-scroll-up = "echo";
                on-scroll-down = "echo";
                tooltip = false;
              };
            };
          }];
        };

        wayland.windowManager.sway.config.bars = [ { command = "waybar"; } ];
      };
    };
}
