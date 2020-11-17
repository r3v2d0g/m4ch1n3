{ machine = { inputs, ... }:
    { nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    };

  users = { config, inputs, lib, pkgs, ... }:
    { imports = [ inputs.nix-doom-emacs.hmModule ];

      home.packages = [ pkgs.vim ];
    };
}
