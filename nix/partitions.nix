{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.partitions];

  partitionedAttrs.checks = "dev";
  partitions.dev.extraInputsFlake = ./_dev-flake;
}
