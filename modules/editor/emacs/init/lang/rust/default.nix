{ config, lib, pkgs, ... }:

let flags = config.m4ch1n3.editor.emacs.init.lang.rust.flags;

in { flags = [ "lsp" ];

     packages = lib.optional flags.lsp pkgs.rust-analyzer;
   }
