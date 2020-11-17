{ machine = { ... }: {};

  users = { config, inputs, lib, pkgs, ... }:
    { home.packages =
        [ pkgs.bat
          pkgs.bottom
          pkgs.du-dust
          pkgs.exa
          pkgs.htop
          pkgs.wget
        ];

      programs.zsh =
        { enable = true;
          enableAutosuggestions = true;
          enableCompletion = true;

          autocd = true;
          defaultKeymap = "emacs";

          history.ignoreDups = true;
          history.ignoreSpace = true;

          oh-my-zsh =
            { enable = true;
              plugins = [ "sudo" ];
            };

          plugins =
            [ { name = "zsh-autopair";
                src = inputs.zsh-autopair;
              }

              { name = "zsh-syntax-highlighting";
                src = inputs.zsh-syntax-highlighting;
              }
            ];

          initExtraBeforeCompInit =
            ''
               setopt PROMPT_SUBST
            '';

          sessionVariables =
            { "PROMPT"  = " %B%F{11}%n%f@%F{13}%M%f:%F{12}%3~ %f%b ";
              "RPROMPT" = "%(?.%F{7}.%F{9})\\$(printf \"%03d\" \\$?)%f ";

              "EDITOR" = "emacs -nw";
              "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" = "fg=7";
            };

          shellAliases =
            { "du" = "${pkgs.du-dust}/bin/dust";
              "l"    = "${pkgs.exa}/bin/exa -l";
              "ls"   = "${pkgs.exa}/bin/exa";
              "quit" = "exit";
              "tree" = "${pkgs.exa}/bin/exa -T";
            } // lib.optionalAttrs
              (config.m4ch1n3.wm.enable && config.m4ch1n3.wm.term.enable)
              { "icat" = "kitty +kitten icat"; };
        };
    };
}
