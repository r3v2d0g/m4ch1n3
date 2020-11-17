{ config, lib, ... }:

let flags = config.m4ch1n3.editor.emacs.init.lang.python.flags;
    pythonPackages = config.m4ch1n3.dev.python.packages;

in { flags =
       [ "conda"
         "cython"
         "lsp"
         "poetry"
         "pyenv"
         "pyright"
       ];

     packages =
       [ pythonPackages.isort
         pythonPackages.nose
         pythonPackages.pyflakes
         pythonPackages.pytest
       ]
       ++ lib.optional flags.conda pythonPackages.conda
       ++ lib.optional flags.cython pythonPackages.cython
       ++ lib.optional flags.poetry pythonPackages.poetry;
   }
