{
  machine = { lib, mcfg, pkgs, ... }:
    let
      cfg = mcfg.theme.grub;
      enable = mcfg.base.boot.bootloader;
      colors = mcfg.theme.colors;

      theme = pkgs.writeTextFile {
        name = "grub-theme";
        destination = "/theme.txt";

        text = ''
          title-text: ""
          desktop-color: "${colors.${cfg.colors.background}}"
          terminal-font: "${cfg.font.name}"

          + boot_menu {
              left = 5%
              top = 5%
              width = 90%
              height = 90%-20

              item_font = "${cfg.font.name}"
              item_color = "${colors.${cfg.colors.item.normal}}"
              item_height = 40
              item_padding = 0
              item_spacing = 0
              item_icon_space = 0

              selected_item_font = "${cfg.font.name}"
              selected_item_color = "${colors.${cfg.colors.item.selected}}"

              icon_width = 0
              icon_height = 0

              scrollbar = false
          }

          + progress_bar {
              left = 5%
              top = 95%-20
              width = 90%
              height = 20

              id = "__timeout__"
              text = ""

              bg_color = "${colors.${cfg.colors.background}}"
              fg_color = "${colors.${cfg.colors.progress}}"
              border_color = "${colors.${cfg.colors.background}}"
          }
        '';
      };
    in {
      options.m4ch1n3.theme.grub = {
        colors = {
          background = lib.mkOptColor "bg";
          progress = lib.mkOptColor "blue";

          item.normal = lib.mkOptColor "fg_alt";
          item.selected = lib.mkOptColor "fg";
        };

        font = lib.mkOptFontPath "Noto Sans Mono" pkgs.noto-fonts
          "share/fonts/truetype/noto/NotoSansMono-Regular.ttf";
      };

      config.boot.loader.grub = lib.mkIf enable {
        inherit theme;

        font = "${cfg.font.package}/${cfg.font.path}";

        splashImage = lib.mkForce null;
      };
    };

  users = { ... }: {};
}
