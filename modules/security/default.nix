{
  machine = { ... }: {};

  users = { pkgs, ... }: {
    home.packages = [ pkgs.openssl ];

    home.sessionVariables = {
      "OPENSSL_INCLUDE_DIR" = "${pkgs.openssl.dev}/include";
      "OPENSSL_LIB_DIR" = "${pkgs.openssl.out}/lib";
    };
  };
}
