{ machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.wm.browser;
      enable = mcfg.wm.enable && cfg.enable;
    in {
      options.m4ch1n3.wm.browser = {
        enable = lib.mkOptBool true;

        extensions = lib.mkOptStrList [];
      };

      config.programs.chromium = lib.mkIf enable {
        enable = true;

        defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
        defaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";

        extensions = cfg.extensions;

        extraOpts = {
          "DefaultSearchProviderEnabled" = true;
          "DefaultSearchProviderName" = "DuckDuckGo";
        };
      };
    };

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.wm.browser;
      enable = mcfg.wm.enable && mcfg.wm.browser.enable
               && ucfg.wm.enable
               && cfg.enable;

      ungoogled-chromium = pkgs.ungoogled-chromium.override (_: {
        enableVaapi = true;
        enableWideVine = true;
      });

      chromium = pkgs.runCommandLocal "ungoogled-chromium" {
        buildInputs = [ pkgs.makeWrapper ];
      } ''
        mkdir -p $out
        ln -s ${ungoogled-chromium}/* $out

        rm $out/bin
        mkdir $out/bin

        makeWrapper ${ungoogled-chromium}/bin/chromium $out/bin/chromium \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "--ozone-platform=wayland"

        ln -s $out/bin/chromium $out/bin/chromium-browser
      '';
    in {
      options.m4ch1n3.wm.browser.enable = lib.mkOptBool true;

      config.programs.chromium = lib.mkIf enable {
        enable = true;

        package = chromium;
      };
    };
}
