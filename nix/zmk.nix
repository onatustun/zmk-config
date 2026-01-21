{
  perSystem = {
    lib,
    self',
    inputs',
    ...
  }: let
    root = ./..;
    build = lib.lists.head (lib.strings.fromJSON (lib.strings.readFile (root + /build.yaml))).include;
  in {
    packages = {
      default = self'.packages.firmware;

      firmware = inputs'.zmk-nix.legacyPackages.buildSplitKeyboard {
        name = "firmware";

        src = lib.fileset.toSource {
          inherit root;

          fileset =
            lib.fileset.intersection (lib.fileset.gitTracked root)
            (root + /config);
        };

        inherit (build) board;

        shield = "${lib.strings.concatStringsSep "_"
          (lib.lists.init (lib.strings.splitString "_"
              build.shield))}_%PART%";

        zephyrDepsHash = "sha256-DwawsaqFBeOqPyAy/aACLooo6OfvhM25qqqqSx/MB1Q=";

        meta = {
          description = "ZMK firmware";
          license = lib.licenses.mit;
          platforms = lib.platforms.all;
        };
      };

      inherit (inputs'.zmk-nix.packages) update;

      flash =
        inputs'.zmk-nix.packages.flash.override
        {inherit (self'.packages) firmware;};
    };
  };

  partitions.dev.module.perSystem = {
    self',
    inputs',
    ...
  }: {
    checks = {
      default = self'.checks.firmware;
      inherit (self'.packages) firmware flash update;
    };

    devShells.default = self'.devShells.zmk;
    make-shells.zmk.inputsFrom = [inputs'.zmk-nix.devShells.default];
  };
}
