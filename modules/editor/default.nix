{ machine = { inputs, ... }:
    { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    };

  users = { config, inputs, lib, ... }:
    let doom-emacs = { pkgs, ... }@args: lib.recursiveUpdate
      (inputs.nix-doom-emacs.hmModule args)
      { options.programs.doom-emacs.doomPrivateDir.apply = v: v; };

    in { imports = [ doom-emacs ]; };
}
