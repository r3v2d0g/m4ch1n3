{
  machine = { lib, pkgs, mcfg, ... }:
    let
      cfg = mcfg.base;
    in {
      options.m4ch1n3.base = { trustedUsers = lib.mkOptStrList [ "@wheel" ]; };

      config = {
        time.timeZone = "Europe/Paris";

        nix.package = pkgs.nixFlakes;
        nix.extraOptions = "experimental-features = nix-command flakes";
        nix.trustedUsers = [ "root" ] ++ cfg.trustedUsers;

        nixpkgs.config = {
          allowUnfree = true;
          joypixels.acceptLicense = true;
        };
      };
    };

  users = { ... }: { home.language.base = "en_US.UTF-8"; };
}
