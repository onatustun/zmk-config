{
  partitionedAttrs.formatter = "dev";

  partitions.dev.module = {inputs, ...}: {
    imports = [inputs.treefmt-nix.flakeModule];

    perSystem = {config, ...}: {
      make-shells.zmk.inputsFrom = [config.treefmt.build.devShell];
      pre-commit.settings.hooks.treefmt.enable = true;

      treefmt = {
        enableDefaultExcludes = true;
        flakeCheck = true;
        flakeFormatter = true;

        programs = {
          alejandra.enable = true;
          deadnix.enable = true;
          prettier.enable = true;
          statix.enable = true;
        };
      };
    };
  };
}
