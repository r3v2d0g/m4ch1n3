{ lib }:

with lib;

let
  mkOpt = type: default:
    mkOption { inherit type; } // optionalAttrs (! isNull default) { inherit default; };

  mkOptList = type: mkOpt (types.listOf type);
  mkOptAttrs = type: mkOpt (types.attrsOf type);

  mkOptNull = type: default: mkOption {
    inherit default;
    type = types.nullOr type;
  };

  submodType = submod: types.submodule ({ name, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        default = name;
        visible = false;
      };
    } // submod;
  });

  colorNames = [
    "bg"
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
in
rec {
  inherit colorNames;

  mkOptAny = default: mkOption { inherit default; };

  mkOptBool = mkOpt types.bool;
  mkOptInt = mkOpt types.int;
  mkOptStr = mkOpt types.str;
  mkOptPath = mkOpt types.path;
  mkOptPkg = mkOpt types.package;
  mkOptEnum = enum: mkOpt (types.enum enum);
  mkOptEnumFrom = from: mkOptEnum (attrNames from);

  mkOptBoolList = mkOptList types.bool;
  mkOptIntList = mkOptList types.int;
  mkOptStrList = mkOptList types.str;
  mkOptPathList = mkOptList types.path;
  mkOptPkgList = mkOptList types.package;
  mkOptEnumList = enum: mkOptList (types.enum enum);
  mkOptEnumFromList = from: mkOptEnumList (attrNames from);

  mkOptBoolAttrs = mkOptAttrs types.bool;
  mkOptIntAttrs = mkOptAttrs types.int;
  mkOptStrAttrs = mkOptAttrs types.str;
  mkOptPathAttrs = mkOptAttrs types.path;
  mkOptPkgAttrs = mkOptAttrs types.pkg;
  mkOptEnumAttrs = enum: mkOptAttrs (types.enum enum);
  mkOptEnumFromAttrs = from: mkOptEnumAttrs (attrNames from);

  mkOptBoolNull = mkOptNull types.bool;
  mkOptIntNull = mkOptNull types.int;
  mkOptStrNull = mkOptNull types.str;
  mkOptPathNull = mkOptNull types.path;
  mkOptPkgNull = mkOptNull types.pkg;
  mkOptEnumNull = enum: mkOptNull (types.enum enum);
  mkOptEnumFromNull = from: mkOptEnumNull (attrNames from);

  mkOptSubmod = submod: mkOpt (submodType submod);
  mkOptSubmodAttrs = submod: mkOptAttrs (submodType submod);

  mkOptSubmodSubst = submod: subst: mkOpt (
    submod.substSubModules (builtins.map subst submod.getSubModules)
  );

  mkOptSubmodListSubst = mkOptSubmodSubst;
  mkOptSubmodAttrsSubst = mkOptSubmodSubst;

  mkOptFont = name: pkg: {
    name = mkOptStr name;
    package = mkOptPkg pkg;
  };

  mkOptFontPath = name: pkg: path:
    mkOptFont name pkg // { path = mkOptStr path; };

  mkOptColor = mkOptEnum colorNames;
  mkOptColorList = mkOptEnumList colorNames;

  mkOptInternal = default:
    mkOption { internal = true; } // optionalAttrs (! isNull default) { inherit default; };
}
