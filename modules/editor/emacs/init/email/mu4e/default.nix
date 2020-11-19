{ pkgs, ... }:

{ flags = [ "gmail" ];

  packages =
    [ pkgs.isync
      pkgs.mu
    ];
}
