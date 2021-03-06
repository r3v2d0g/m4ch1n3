{ inputs, lib, pkgs, ... }:

let
  modules = args: (import ../modules).machine (args // { inherit inputs lib; });
in {
  imports = [ modules ];

  nixpkgs.overlays = [
    (import inputs.nixpkgs-mozilla)
    (import inputs.emacs-overlay)
    (import ../overlays inputs)
  ];
}
