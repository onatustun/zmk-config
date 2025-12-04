{
  perSystem = {
    self',
    pkgs,
    config,
    inputs',
    ...
  }: {
    devShells = {
      default = self'.devShells.zmk-config;

      zmk-config = pkgs.mkShell {
        name = "zmk-config-dev";
        shellHook = config.pre-commit.installationScript;

        inputsFrom = [
          config.pre-commit.devShell
          config.treefmt.build.devShell
          inputs'.zmk-nix.devShells.default
          self'.packages.default
        ];
      };

      zmk-nix = inputs'.zmk-nix.devShells.default;
    };
  };
}
