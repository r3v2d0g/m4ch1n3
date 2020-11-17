{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.wm.browser;
        enable = config.m4ch1n3.wm.enable;

    in { options.m4ch1n3.wm.browser = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "web browser";

             extensions = lib.mkListOfStrOption
               { default = []; };
           };

         config.programs.chromium = lib.mkIf (enable && cfg.enable)
           { enable = true;

             defaultSearchProviderSearchURL =
               "https://duckduckgo.com/?q={searchTerms}";

             defaultSearchProviderSuggestURL =
               "https://duckduckgo.com/ac/?q={searchTerms}&type=list";

             extensions = cfg.extensions;

             extraOpts =
               { "DefaultSearchProviderEnabled" = true;
                 "DefaultSearchProviderName" = "DuckDuckGo";
               };
           };
       };

  users = { config, lib, mconfig, pkgs, ... }:
    let cfg = config.m4ch1n3.wm.browser;
        enable = mconfig.m4ch1n3.wm.enable
                 && mconfig.m4ch1n3.wm.browser.enable
                 && config.m4ch1n3.wm.enable;

        ungoogled-chromium = pkgs.ungoogled-chromium
          .overrideAttrs (_: { name = "chromium"; } );

    in { options.m4ch1n3.wm.browser = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "web browser"; };

         config.programs.chromium = lib.mkIf (enable && cfg.enable)
           { enable = true;

             package = ungoogled-chromium
               .override (_:
                 { proprietaryCodecs = true;
                   enableWideVine = true;
                 }
               );
           };
       };
}
