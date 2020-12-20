{
  description = "m4ch1n3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-mesa.url = "github:nixos/nixpkgs/1857b270f7570471945fe9a15d3abbacb7fd6abf";

    emacs-overlay.url = "github:nix-community/emacs-overlay/0b93526e09d3dae90144eadda1b8e80aad7e0333";
    home-manager.url = "github:r3v2d0g/home-manager"; # NOTE: forked
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:r3v2d0g/nix-doom-emacs"; # NOTE: forked

    ion-mode = {
      url = "github:iwahbe/ion-mode";
      flake = false;
    };

    jq-zsh-plugin = {
      url = "github:reegnz/jq-zsh-plugin";
      flake = false;
    };

    proton-bridge = {
      url = "github:ProtonMail/proton-bridge/br-1.5.0";
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
