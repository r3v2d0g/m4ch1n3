{ lib }:

with lib;

lib // rec {
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

  # [string] -> string
  concatStringsNl = strings:
    concatStringsSep "\n" strings;

  # [string] -> string
  concatStringsWs = strings:
    concatStringsSep " " strings;

  # {a = b} -> string
  concatAttrNamesNl = attrs:
    concatStringsNl (attrNames attrs);

  # {a = b} -> string
  concatAttrValuesNl = attrs:
    concatStringsNl (attrValues attrs);

  # (string -> string) -> [string] -> string
  concatMapStringsNl = m: strings:
    concatMapStringsSep "\n" m strings;

  # (string -> string) -> [string] -> string
  concatMapStringsWs = m: strings:
    concatMapStringsSep " " m strings;

  # (a -> string) -> {a = b} -> string
  concatMapAttrNamesNl = m: attrs:
    concatMapStringsNl m (attrNames attrs);

  # (a -> b -> c) -> {a = b} -> [c]
  mapAttrsValues = m: attrs:
    attrValues (mapAttrs m attrs);

  # (a -> b -> c) -> (a -> b -> bool) -> {a = b} -> {a = c}
  mapFilterAttrs = m: f: attrs:
    mapAttrs m (filterAttrs f attrs);

  # (a -> b -> c) -> (a -> b -> bool) -> {a = b} -> [c]
  mapFilterAttrsValues = m: f: attrs:
    mapAttrsValues m (filterAttrs f attrs);

  # (a -> b -> c -> d) -> {a = {b = c}} -> {a = {b = d}}
  mapAttrsAttrs = m: attrs:
    mapAttrs (n: mapAttrs (m n)) attrs;

  # (a -> b -> c -> d) -> (a -> b -> c -> bool) -> {a = {b = c}} -> {a = {b = d}}
  mapFilterAttrsAttrs = m: f: attrs:
    mapAttrs (n: mapFilterAttrs (m n) (f n)) attrs;

  # (a -> b -> c -> d) -> (a -> b -> c -> bool) -> {a = {b = c}} -> [[d]]
  mapFilterAttrsAttrsValues = m: f: attrs:
    attrValues (mapAttrs (n: v: attrValues (mapFilterAttrs (m n) (f n) v)) attrs);

  # (a -> b -> bool) -> {a = b} -> [a]
  filterAttrsNames = f: attrs:
    attrNames (filterAttrs f attrs);

  # (a -> b -> bool) -> {a = b} -> b
  filterAttrsValues = f: attrs:
    attrValues (filterAttrs f attrs);

  # {a = b} -> [{a = b}] -> {a = b}
  recursiveUpdates = attrs: list:
    foldr recursiveUpdate attrs list;

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
