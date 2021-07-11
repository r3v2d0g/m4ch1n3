{
  machine = { lib, pkgs, mcfg, ... }:
    let enable = mcfg.db.enable && mcfg.db.pg.enable;
    in {
      options.m4ch1n3.db.pg.enable = lib.mkOptBool false;

      config.services.postgresql = lib.mkIf enable {
        enable = true;
        package = pkgs.postgresql;
        enableTCPIP = true;
        authentication = pkgs.lib.mkOverride 10 ''
          local all all trust
          host all all ::1/128 trust
        '';

        settings.listen_addresses = lib.mkForce "localhost";
      };
    };

  users = { ... }: {};
}
