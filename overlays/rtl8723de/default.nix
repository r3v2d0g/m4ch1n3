{ bc, kernel, src, stdenv }:

stdenv.mkDerivation {
  name = "rtl8723de";
  inherit src;

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
