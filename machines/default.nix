{ inputs, lib, ... }:

let modules = args:
      (import ../modules).machine (args // { inherit inputs lib; });

in { imports = [ modules ];

     nixpkgs.overlays = [ (import ../overlays inputs) ];
   }
