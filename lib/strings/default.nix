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
  concatMapStringsNl =
    concatMapStringsSep "\n";

  # (string -> string) -> [string] -> string
  concatMapStringsWs =
    concatMapStringsSep " ";

  # (a -> string) -> {a = b} -> string
  concatMapAttrNamesNl = m: attrs:
    concatMapStringsNl m (attrNames attrs);
}
