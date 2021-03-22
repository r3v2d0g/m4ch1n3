{ bc, fetchFromGitHub, kernel, stdenv }:

stdenv.mkDerivation {
  name = "rtl8723de";
  src = fetchFromGitHub {
    owner = "smlinux";
    repo = "rtl8723de";
    rev = "0be0a4a5113e0e60e866da77da3b3c7dd03c86ef";
    sha256 = "1w02jkss0ic0wbba2hbfvakqjhjy0x7ifr8dg9dqcr82rjrhfrlf";
  };

  hardeningDisable = [ "pic" ];
  enableParallelBuilding = true;
  skipStrip = true;

  nativeBuildInputs = kernel.moduleBuildDependencies ++ [ bc ];

  makeFlags = [ "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];

  installPhase = ''
    install -vDm 644 8723de.ko \
      "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/realtek/rtl8723de.ko"
  '';
}
