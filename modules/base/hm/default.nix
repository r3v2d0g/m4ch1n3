{
  machine = { inputs, lib, pkgs, utils, ... }@args:
    let
      hm = inputs.home-manager.nixosModules.home-manager args;
      hmOpts = hm.options.home-manager;

      overrides = [
        {
          path = [ "options" "programs" "waybar" "settings" ];
          override = prev: lib.mkOptSubmodListSubst prev.type (mod: {
            options = mod.options // {
              layer = lib.mkOptEnumNull [ "top" "bottom" "overlay" ] null;
            };
          }) [];
        }
      ];
    in {
      inherit (hm) config;

      options.home-manager = hmOpts // {
        users = lib.mkOptSubmodAttrsSubst hmOpts.users.type (mod: { name, ... }@args:
          let
            hmMod = mod args;
          in {
            inherit (hmMod) config;

            imports = builtins.map (mod: { pkgs, ... }@args:
              lib.overrides (lib.callOrImport mod args) overrides
            ) hmMod.imports;
          }
        ) {};
      };
    };

  users = { ... }: {};
}
