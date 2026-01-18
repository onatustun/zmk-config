{
  partitionedAttrs.devShells = "dev";

  partitions.dev.module = {inputs, ...}: {
    imports = [inputs.make-shell.flakeModules.default];
  };
}
