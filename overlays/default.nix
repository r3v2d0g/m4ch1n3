{ fmt
, ...
}:

self: super:

{
  cypress = import ./cypress { inherit (super) cypress fetchurl; };

  fmt = super.fmt.overrideAttrs (prev: {
    src = fmt;
    version = "7.0.3";
  });

  megacmd = import ./megacmd { inherit (super) fetchFromGitHub megacmd; };

  nodejs-latest = super.nodejs-16_x;

  yarn-latest = super.yarn.overrideAttrs (prev: { buildInputs = [ self.nodejs-latest ]; });

  p7zip = super.p7zip.override { enableUnfree = true; };

  paper-icon-theme = import ./paper-icon-theme {
    inherit (super) fetchFromGitHub paper-icon-theme;
  };

  rtl8723de = import ./rtl8723de {
    inherit (super) bc fetchFromGitHub stdenv;
    kernel = self.linux;
  };

  rust-nightly = import ./rust-nightly { inherit (super) rustChannelOf; };

  ungoogled-chromium = super.ungoogled-chromium.override (prev: {
    enableWideVine = true;
  });

  waybar = import ./waybar { inherit (super) fetchFromGitHub waybar; };
}
