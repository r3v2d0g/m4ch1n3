{ mcfg, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && ucfg.dev.rust.enable;
in {
  inherit default;

  flags.lsp = true;

  packages = [];
}
