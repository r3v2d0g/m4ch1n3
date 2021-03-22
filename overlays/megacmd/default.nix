{ fetchFromGitHub, megacmd }:

megacmd.overrideAttrs (_: rec {
  version = "1.4.0";
  src = fetchFromGitHub {
    owner = "meganz";
    repo = "MEGAcmd";
    rev = "${version}_Linux";
    sha256 = "11wc8jpkqdy4g9zb5m24akiqzj22sf3mbnbgzm0006ng6i49jm23";
    fetchSubmodules = true;
  };
})
