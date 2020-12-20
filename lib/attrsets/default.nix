{ lib }:

with lib;

rec {
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
    foldr recursiveUpdate;

  # {a = b} -> [{path = [string]; override = ({a = b} -> {c = d})}] -> {c = d}
  overrides =
    foldr (lib.flip override);

  # {a = b} -> {path = [string]; override = ({a = b} -> {c = d})} -> {c = d}
  override = attrs: { path, override, ... }:
    if hasAttrByPath path attrs
    then recursiveUpdate attrs (setAttrByPath path (override (getAttrFromPath path attrs)))
    else attrs;
}
