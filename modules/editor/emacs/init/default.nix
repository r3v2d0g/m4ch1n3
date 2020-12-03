{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, ... }@args:
    let
      cfg = ucfg.editor.emacs.init;
      enable = mcfg.editor.emacs.enable && ucfg.editor.emacs.enable;

      modules = {
        app = import ./app args;
        checkers = import ./checkers args;
        completion = import ./completion args;
        config = import ./config args;
        editor = import ./editor args;
        emacs = import ./emacs args;
        email = import ./email args;
        input = import ./input args;
        lang = import ./lang args;
        os = import ./os args;
        term = import ./term args;
        tools = import ./tools args;
        ui = import ./ui args;
      };

      initel = ''
        ;;; init.el -*- lexical-binding: t; -*-

        (doom! ${category "input"}
               ${category "completion"}
               ${category "ui"}
               ${category "editor"}
               ${category "emacs"}
               ${category "term"}
               ${category "checkers"}
               ${category "tools"}
               ${category "os"}
               ${category "lang"}
               ${category "email"}
               ${category "app"}
               ${category "config"})
      '';

      category = cat: ''
        :${cat}
        ${lib.concatMapAttrNamesNl (module cat) modules.${cat}}
      '';

      module = cat: mod:
        if (isNull modules.${cat}.${mod}) || (! cfg.${cat}.${mod}.enable)
        then ";;${mod}"
        else flags cat mod;

      flags = cat: mod:
        let
          enabled = lib.filterAttrsNames (_: flag: flag) cfg.${cat}.${mod}.flags;
        in
          if enabled == []
          then mod
          else ''(${mod} ${lib.concatMapStringsWs (flag: "+${flag}") enabled})'';
    in {
      options.m4ch1n3.editor.emacs.init = lib.optionalAttrs enable (lib.mapFilterAttrsAttrs
        (cat: mod: { default, flags, ... }: {
          enable = lib.mkOptBool default;
          flags = lib.mapAttrs (_: default: lib.mkOptBool default) flags;
        }) (_: _: val: ! isNull val) modules
      );

      config = lib.mkIf enable {
        m4ch1n3.editor.emacs.initel = initel;

        home.packages = lib.flatten (lib.mapFilterAttrsAttrsValues
          (cat: mod: _: modules.${cat}.${mod}.packages)
          (_: _: { enable, ... }: enable)
          cfg
        );
      };
    };
}
