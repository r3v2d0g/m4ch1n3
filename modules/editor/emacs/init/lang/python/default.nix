{ lib, mcfg, pkgs, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && ucfg.dev.python.enable;
  flags = ucfg.editor.emacs.init.lang.python.flags;
  pythonPackages = ucfg.dev.python.packages;
in {
  inherit default;

  flags.conda = false;
  flags.cython = false;
  flags.lsp = true;
  flags.poetry = false;
  flags.pyenv = false;
  flags.pyright = false;

  packages = [
    pythonPackages.isort
    pythonPackages.nose
    pythonPackages.pyflakes
    pythonPackages.pytest
  ]
  ++ lib.optional flags.conda pythonPackages.conda
  ++ lib.optional flags.cython pythonPackages.cython
  ++ lib.optional flags.lsp pkgs.python-language-server
  ++ lib.optional flags.poetry pythonPackages.poetry;
}
