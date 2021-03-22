{
  machine = { inputs, lib, pkgs, mcfg, ... }:
    let
      cfg = mcfg.base;
    in {
      options.m4ch1n3.base = { trustedUsers = lib.mkOptStrList [ "@wheel" ]; };

      config = {
        time.timeZone = "Europe/Paris";

        nix.package = pkgs.nixFlakes;
        nix.extraOptions = "experimental-features = nix-command flakes";
        nix.trustedUsers = [ "root" ] ++ cfg.trustedUsers;

        nix.nixPath = lib.mkForce [
          "nixpkgs=${inputs.nixpkgs}"
          "${inputs.nixpkgs}"
        ];

        nixpkgs.config = {
          allowUnfree = true;
          joypixels.acceptLicense = true;
        };
      };
    };

  users = { inputs, options, lib, ... }: {
    home.language.base = "en_US.UTF-8";

    home.file.".config/nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';
  };
}
