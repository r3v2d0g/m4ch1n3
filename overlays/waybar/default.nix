{ fetchFromGitHub, waybar }:

waybar.overrideAttrs (prev: rec {
  version = "0.9.5";
  src = fetchFromGitHub {
    owner = "Alexays";
    repo = "Waybar";
    rev = version;
    sha256 = "1kzrgqaclfk6gcwhknxn28xl74gm5swipgn8kk8avacb4nsw1l9q";
  };

  patches = (prev.patches or [])
            ++ [ ./patches/0001-no-exclusive-zone-for-overlay.patch ];
})
