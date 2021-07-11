{
  description = "m4ch1n3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs/";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";

    ion-mode = {
      url = "github:iwahbe/ion-mode";
      flake = false;
    };

    jq-zsh-plugin = {
      url = "github:reegnz/jq-zsh-plugin";
      flake = false;
    };

    nixpkgs-mozilla = {
      url = "github:andersk/nixpkgs-mozilla/stdenv.lib";
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

  outputs = { nixpkgs, ... }@inputs:
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
          ];
        };

        sf4r = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (withInputsAndLib ./machines)
            (withInputsAndLib ./users)

            ({ pkgs, ... }@args: { config.m4ch1n3 = import ./machines/sf4r args; })
          ];
        };
      };
    };
}
