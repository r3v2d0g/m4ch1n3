{ lib }:

with lib;

rec {
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
}
