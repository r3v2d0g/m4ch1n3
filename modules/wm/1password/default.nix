{ machine = { ... }: {};

  users = { config, lib, mconfig, pkgs, ... }:
    let cfg = config.m4ch1n3.wm.onepassword;
        theme = config.m4ch1n3.theme.wm.onepassword;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable;

    in { options.m4ch1n3.wm.onepassword = lib.optionalAttrs enable
           { enable = lib.mkEnableOption "1password";

             autolock.minutes = lib.mkNullOrIntOption
               { default = null; };

             autolock.onDeviceLock = lib.mkNullOrBoolOption
               { default = true; };

             autolock.onWindowClose = lib.mkNullOrBoolOption
               { default = null; };

             authenticatedUnlock.enabled = lib.mkEnableOption
               "unlock using the OS user credentials or biometrics";

             clipboard.clearAfter = lib.mkNullOrIntOption
               { default = 30; };
           };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages = [ pkgs._1password-gui ];

             home.file.".config/1Password/settings/settings.json".text =
               builtins.toJSON (
                 { "$schema" = "https://onepassword.s3.amazonaws.com/schema/settings.json";
                   "security.authenticatedUnlock.enabled" = cfg.authenticatedUnlock.enabled;
                 } // lib.optionalAttrs (! isNull theme.theme)
                     { "app.theme" = theme.theme; }
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
