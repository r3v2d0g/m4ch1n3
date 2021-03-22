{ cypress, fetchurl }:

cypress.overrideAttrs (_: rec {
  version = "6.5.0";
  src = fetchurl {
    url = "https://cdn.cypress.io/desktop/${version}/linux-x64/cypress.zip";
    sha256 = "1gpk0vmz2l8p4q0asd4dhw029ppn8hx0yvznd9clks3anbx3sh7g";
  };
})
