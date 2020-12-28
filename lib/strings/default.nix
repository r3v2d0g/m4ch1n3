{ lib }:

with lib;

rec {
  # [string] -> string
  concatStringsNl =
    concatStringsSep "\n";

  # [string] -> string
  concatStringsWs =
    concatStringsSep " ";

  # [string] -> string
  concatStringsColon =
    concatStringsSep ":";

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
}
