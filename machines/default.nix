{ inputs, ... }:

let modules = args:
      (import ../modules).machine
        (args // { inherit inputs; });

in { imports = [ modules ];

     nixpkgs.overlays = [ (import ../overlays inputs) ];
   }
