{ machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.wm.onepassword;
      theme = ucfg.theme.wm.onepassword;
      enable = mcfg.wm.enable && ucfg.wm.enable;
    in {
      options.m4ch1n3.wm.onepassword = lib.optionalAttrs enable {
        enable = lib.mkOptBool false;

        autolock.minutes = lib.mkOptIntNull null;
        autolock.onDeviceLock = lib.mkOptIntNull null;
        autolock.onWindowClose = lib.mkOptIntNull null;

        authenticatedUnlock.enabled = lib.mkOptBool false;

        clipboard.clearAfter = lib.mkOptIntNull 30;
      };

      config = lib.mkIf (enable && cfg.enable) {
        home.packages = [ pkgs._1password-gui ];

        home.file.".config/1Password/settings/settings.json".text = builtins.toJSON ({
          "$schema" = "https://onepassword.s3.amazonaws.com/schema/settings.json";
          "security.authenticatedUnlock.enabled" = cfg.authenticatedUnlock.enabled;
        }
        // lib.optionalAttrs (! isNull theme.theme) { "app.theme" = theme.theme; }
        // lib.optionalAttrs (! isNull cfg.autolock.minutes)
          { "security.autolock.minutes" = cfg.autolock.minutes; }
        // lib.optionalAttrs (! isNull cfg.autolock.onDeviceLock)
          { "security.autolock.onDeviceLock" = cfg.autolock.onDeviceLock; }
        // lib.optionalAttrs (! isNull cfg.autolock.onWindowClose)
          { "security.autolock.onWindowClose" = cfg.autolock.onWindowClose; }
        // lib.optionalAttrs (! isNull cfg.clipboard.clearAfter)
          { "security.clipboard.clearAfter" = cfg.clipboard.clearAfter; }
        );
      };
    };
}
