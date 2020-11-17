{ machine = { inputs, pkgs, ... }:
    { time.timeZone = "Europe/Paris";

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.joypixels.acceptLicense = true;

      nix =
        { package = pkgs.nixFlakes;
          extraOptions =
            ''
               experimental-features = nix-command flakes
            '';
        };
    };

  users = { ... }:
    { home.language.base = "en_US.UTF-8"; };
}
