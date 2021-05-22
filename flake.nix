{
  description = "m4ch1n3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nix-ld.url = "github:Mic92/nix-ld";

    emacs-overlay.url = "github:nix-community/emacs-overlay/d9530a7048f4b1c0f65825202a0ce1d111a1d39a";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs/746c847149f3d40ea952038f7fe78ce0d7808138";
    nix-doom-emacs.inputs.doom-emacs.follows = "doom-emacs";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";

    doom-emacs = {
      url = "github:rgrinberg/doom-emacs/dhall-mode";
      flake = false;
    };

    fmt = {
      url = "github:fmtlib/fmt/7.0.3";
      flake = false;
    };

    ion-mode = {
      url = "github:iwahbe/ion-mode";
      flake = false;
    };

    jq-zsh-plugin = {
      url = "github:reegnz/jq-zsh-plugin";
      flake = false;
    };

    nixpkgs-mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
      flake = false;
    };

    paper-icon-theme = {
      url = "github:snwh/paper-icon-theme";
      flake = false;
    };

    zsh-autopair = {
      url = "github:hlissner/zsh-autopair";
      flake = false;
    };

    zsh-bd = {
      url = "github:Tarrasch/zsh-bd";
      flake = false;
    };

    zsh-nix-shell = {
      url = "github:chisui/zsh-nix-shell";
      flake = false;
    };

    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };
  };

  outputs = { nixpkgs, nix-ld, ... }@inputs:
    let
      withInputsAndLib = path: { pkgs, ... }@args:
        let lib = import ./lib { lib = args.lib; };
        in import path (args // { inherit inputs lib; });
    in {
      nixosConfigurations = {
        a5k4 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (withInputsAndLib ./machines)
            (withInputsAndLib ./users)

            (args: { config.m4ch1n3 = import ./machines/a5k4 args; })

            nix-ld.nixosModules.nix-ld
          ];
        };

        sf4r = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (withInputsAndLib ./machines)
            (withInputsAndLib ./users)

            ({ pkgs, ... }@args: { config.m4ch1n3 = import ./machines/sf4r args; })

            nix-ld.nixosModules.nix-ld
          ];
        };
      };
    };
}
