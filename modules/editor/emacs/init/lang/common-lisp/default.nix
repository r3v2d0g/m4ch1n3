{ mcfg, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && ucfg.dev.lisp.enable;
in {
  inherit default;

  flags = {};

  packages = [];
}
