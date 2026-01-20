{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.partitions];

  partitionedAttrs = {
    checks = "dev";
    devShells = "dev";
  };

  partitions.dev.extraInputs =
    lib.attrsets.filterAttrs (inputName:
      lib.trivial.const
      (!lib.strings.hasPrefix "dep_" inputName))
    (import inputs.flake-compat
      {src = ./_dev-inputs;}).outputs.inputs;
}
