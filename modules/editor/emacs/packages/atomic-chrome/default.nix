{ mcfg, ucfg, ... }:

let
  enable = mcfg.wm.enable && mcfg.wm.browser.enable
           && ucfg.wm.enable && ucfg.wm.browser.enable;
in {
  default = enable;

  recipe = "";

  packages = [];
}
