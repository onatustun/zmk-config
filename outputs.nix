inputs:
inputs.flake-parts.lib.mkFlake {
  inputs = inputs.nixpkgs.lib.attrsets.filterAttrs (name:
    inputs.nixpkgs.lib.trivial.const
    (!inputs.nixpkgs.lib.strings.hasPrefix "dep_" name))
  inputs;
} (inputs.import-tree ./nix)
