{ pkgs, ... }:

{ flags =
    [ "childframe"
      "fuzzy"
      "icons"
      "prescient"
    ];

  packages = [ pkgs.ripgrep ];
}
