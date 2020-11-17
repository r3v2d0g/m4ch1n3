{ config, lib, pkgs, ... }:

let lang = config.m4ch1n3.editor.emacs.init.lang;

in { flags = [ "onsave" ];

     # TODO: Assembly (asmfmt)
     # TODO: Bazel Starlark (buildifier)
     # TODO: BibTeX (emacs)
     # TODO: C/C++/Objective-C (clang-format)
     # TODO: Cabal (cabal-fmt)
     # TODO: Clojure/ClojureScript (node-cljfmt)
     # TODO: CMake (cmake-format)
     # TODO: Crystal (crystal tool format)
     # TODO: D (dfmt)
     # TODO: Dart (dartfmt)
     # TODO: Dhall (dhall format)
     # TODO: Dockerfile (dockfmt)
     # TODO: Elixir (mix format)
     # TODO: Elm (elm-format)
     # TODO: Fish Shell (fish_indent)
     # TODO: Fortran 90 (fprettify)
     # TODO: Gleam (gleam format)
     # TODO: Go (gofmt)
     # TODO: Java (clang-format)
     # TODO: Jsonnet (jsonnetfmt)
     # TODO: Kotlin (ktlint)
     # TODO: LaTeX (latexindent)
     # TODO: Lua (lua-fmt)
     # TODO: Perl (perltidy)
     # TODO: PHP (prettier plugin-php)
     # TODO: Protocol Buffers (clang-format)
     # TODO: PureScript (purty)
     # TODO: R (styler)
     # TODO: Ruby (rufo)
     # TODO: Scala (scalafmt)
     # TODO: Snakemake (snakefmt)
     # TODO: Solidity (prettier-plugin-solidity)
     # TODO: SQL (sqlformat)
     # TODO: Swift (swiftformat)
     # TODO: Terraform (terraform fmt)
     # TODO: Verilog (iStyle)
     packages = []
                ++ lib.optional lang.haskell.enable pkgs.haskellPackages.brittany
                ++ lib.optional lang.nix.enable pkgs.nixfmt
                ++ lib.optional lang.ocaml.enable pkgs.ocamlPackage.ocp-indent
                ++ lib.optional lang.python.enable pkgs.python38Packages.black
                #++ lib.optional lang.rust.enable pkgs.rustfmt
                ++ lib.optional lang.sh.enable pkgs.shfmt
                ++ lib.optional lang.web.enable pkgs.html-tidy
                ++ lib.optional (
                  lang.javascript.enable
                  || lang.json.enable
                  || lang.markdown.enable
                  || lang.rust.enable
                  || lang.web.enable
                  || lang.yaml.enable
                ) pkgs.nodePackages.prettier;
   }
