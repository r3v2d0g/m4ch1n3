{ machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.wm.browser;
      enable = mcfg.wm.enable;
    in {
      options.m4ch1n3.wm.browser = lib.optionalAttrs enable {
        enable = lib.mkOptBool true;

        extensions = lib.mkOptStrList [];
      };

      config.programs.chromium = lib.mkIf (enable && cfg.enable) {
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
               && ucfg.wm.enable;

      ungoogled-chromium = pkgs.ungoogled-chromium.overrideAttrs (_: {
        name = "chromium";
      });
    in {
      options.m4ch1n3.wm.browser = lib.optionalAttrs enable { enable = lib.mkOptBool true; };

      config.programs.chromium = lib.mkIf (enable && cfg.enable) {
        enable = true;

        package = ungoogled-chromium.override (_: {
          enableVaapi = true;
          enableWideVine = true;
        });
      };
    };
}
