{
  description = "m4ch1n3";

  inputs = {
    nixpkgs.url = "github:r3v2d0g/nixpkgs/develop";

    nixpkgs-mesa.url = "github:nixos/nixpkgs/1857b270f7570471945fe9a15d3abbacb7fd6abf";

    emacs-overlay.url = "github:nix-community/emacs-overlay/4d7fdb786637213e2ff45bb868e27eb21a234f06";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs/c879675c82ff58be42cec7106cd5c6a35fd3da85";
    nix-doom-emacs.inputs.doom-emacs.follows = "doom-emacs";
    nix-doom-emacs.inputs.doom-snippets.follows = "doom-snippets";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";

    doom-emacs = {
      url = "github:hlissner/doom-emacs/d88e0795b68bd0a261872b2c1e80b7b567a862ae";
      flake = false;
    };

    doom-snippets = {
      url = "github:hlissner/doom-snippets/33eb93ba6a6f307ceb89e4e80554a1db328c3e26";
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

    rtl8723de = {
      url = "github:smlinux/rtl8723de";
      flake = false;
    };

    waybar = {
      url = "github:Alexays/Waybar";
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
