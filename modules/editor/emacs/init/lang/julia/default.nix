{ lib, mcfg, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && ucfg.dev.julia.enable;
in {
  inherit default;

  flags.lsp = true;

  packages = [];
}
