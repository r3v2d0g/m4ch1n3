{ lib }@args:

with lib;

lib
// (import ./attrsets args)
// (import ./options args)
// (import ./strings args)
// { term = import ./term args; }
// {
  callOrImport = fnOrPath:
    if isFunction fnOrPath
    then fnOrPath
    else import fnOrPath;
}
