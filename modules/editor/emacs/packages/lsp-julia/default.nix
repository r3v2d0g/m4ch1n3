{ mcfg, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
    && ucfg.editor.emacs.modules.lang.julia.flags.lsp;
in {
  inherit default;

  recipe = ''(:host github :repo "non-jedi/lsp-julia")'';

  packages = [];
}
