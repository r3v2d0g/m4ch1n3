{ pkgs, ... }:

{ flags = [];

  packages =
    [ pkgs.ocamlPackages.dune
      pkgs.ocamlPackages.merlin
      pkgs.ocamlPackage.ocamlformat
      pkgs.ocamlPackages.utop
    ];
}
