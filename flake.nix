{ description = "m4ch1n3";

  inputs =
    { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      emacs-overlay.url = "github:nix-community/emacs-overlay";
      home-manager.url = "github:r3v2d0g/home-manager"; # NOTE: forked
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      nix-doom-emacs.url = "github:r3v2d0g/nix-doom-emacs"; # NOTE: forked

      ion-mode =
        { url = "github:iwahbe/ion-mode";
          flake = false;
        };

      rtl8723de =
        { url = "github:smlinux/rtl8723de";
          flake = false;
        };

      tidal-hifi =
        { url = "github:r3v2d0g/tidal-hifi"; # NOTE: forked
          flake = false;
        };

      vetur =
        { url = "github:r3v2d0g/vetur"; # NOTE: forked
          flake = false;
        };

      waybar =
        { url = "github:Alexays/Waybar";
          flake = false;
        };

      zsh-autopair =
        { url = "github:hlissner/zsh-autopair";
          flake = false;
        };

      zsh-syntax-highlighting =
        { url = "github:zsh-users/zsh-syntax-highlighting";
          flake = false;
        };
    };

  outputs = { nixpkgs, ... }@inputs:
    let withInputs = path: args:
          import path (args // { inherit inputs; });

    in { nixosConfigurations =
           { a5k4 = nixpkgs.lib.nixosSystem
               { system = "x86_64-linux";

                 modules =
                   [ (withInputs ./machines)
                     (withInputs ./users)

                     (args:
                       { config.m4ch1n3 = import ./machines/a5k4 args; }
                     )
                   ];
               };
           };
       };
}
