{ buildGoModule
, fetchFromGitHub
, libsecret
, pkg-config
, source
}:

buildGoModule rec
  { pname = "protonmail-bridge";
    version = "1.5.0";
    src = source;

    shortRev = "9a77650";
    vendorSha256 = "061mffkk7m3pwv2hv0hwvbk9m9pyr28581ra5ibpzdawl1zbpzvq";

    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ libsecret ];

    buildPhase =
      ''
         make BUILD_TIME= build-nogui
      '';

    installPhase =
      ''
         install -Dm 555 Desktop-Bridge $out/bin/protonmail-bridge
      '';
  }
