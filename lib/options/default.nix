{ lib }:

with lib;

rec {
  colorNames =
    [ "bg"
      "bg_alt"
      "base0"
      "base1"
      "base2"
      "base3"
      "base4"
      "base5"
      "base6"
      "base7"
      "base8"
      "fg_alt"
      "fg"

      "grey"
      "red"
      "orange"
      "green"
      "teal"
      "yellow"
      "blue"
      "dark_blue"
      "magenta"
      "violet"
      "cyan"
      "dark_cyan"
    ];

  mkDisableOption = name:
    (mkEnableOption name)
    // { default = true; };

  mkIntOption = attrs:
    mkOption { type = types.int; }
    // attrs;

  mkStrOption = attrs:
    mkOption { type = types.str; }
    // attrs;

  mkPathOption = attrs:
    mkOption { type = types.path; }
    // attrs;

  mkPackageOption = attrs:
    mkOption { type = types.package; }
    // attrs;

  mkListOfStrOption = attrs:
    mkOption { type = types.listOf types.str; }
    // attrs;

  mkListOfPathOption = attrs:
    mkOption { type = types.listOf types.path; }
    // attrs;

  mkAttrsOfStrOption = attrs:
    mkOption { type = types.attrsOf types.str; }
    // attrs;

  mkAttrsOfPackageOption = attrs:
    mkOption { type = types.attrsOf types.package; }
    // attrs;

  mkAttrsOfSubmoduleOption = attrs: options:
    mkOption
      { type = types.attrsOf
          (types.submodule ({ name, ... }:
            { options =
                { name = lib.mkOption
                    { type = types.str;
                      default = name;
                      visible = false;
                    };
                } // options;
            }
          ));
      } // attrs;

  mkEnumOption = enum: attrs:
    mkOption { type = types.enum enum; }
    // attrs;

  mkEnumFromAttrNamesOption = attrs: from:
    mkEnumOption (attrNames from) attrs;

  mkNullOrBoolOption = attrs:
    mkOption { type = types.nullOr types.bool; }
    // attrs;

  mkNullOrIntOption = attrs:
    mkOption { type = types.nullOr types.int; }
    // attrs;

  mkNullOrStrOption = attrs:
    mkOption { type = types.nullOr types.str; }
    // attrs;

  mkNullOrEnumOption = enum: attrs:
    mkOption { type = types.nullOr (types.enum enum); }
    // attrs;

  mkNullOrEnumFromAttrNamesOption = attrs: from:
    mkNullOrEnumOption (attrNames from) attrs;

  mkFontOption = name: package:
    { name = lib.mkOption
        { type = types.str;
          default = name;
        };

      package = lib.mkOption
        { type = types.package;
          default = package;
        };
    };

  mkFontWithPathOption = name: package: path:
    (mkFontOption name package)
    // { path = lib.mkOption
           { type = types.str;
             default = path;
           };
       };

  mkColorOption = attrs:
    mkOption { type = types.enum colorNames; }
    // attrs;

  mkListOfColorsOption = attrs:
    mkOption { type = types.listOf (types.enum colorNames); }
    // attrs;

  mkInternalOption = attrs:
    mkOption { internal = true; }
    // attrs;
}
