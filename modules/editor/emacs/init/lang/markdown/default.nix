{ pkgs, ... }:

{ flags = [ "grip" ];

  packages =
    [ pkgs.mdl
      pkgs.pandoc
      pkgs.proselint
    ];
}
