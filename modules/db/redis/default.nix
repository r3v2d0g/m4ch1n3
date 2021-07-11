{
  machine = { lib, mcfg,... }:
    let enable = mcfg.db.enable && mcfg.db.redis.enable;
    in {
      options.m4ch1n3.db.redis.enable = lib.mkOptBool false;

      config.services.redis = lib.mkIf enable {
        enable = true;
        save = [];
      };
    };

  users = { ... }: {};
}
