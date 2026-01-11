{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    self',
    inputs',
    ...
  }: let
    importYAML = yamlPath: let
      jsonFile =
        pkgs.runCommand "converted.json"
        {nativeBuildInputs = [pkgs.yq-go];} ''
          yq -o json "${yamlPath}" > "$out"
        '';
    in
      lib.strings.fromJSON (lib.strings.readFile jsonFile);

    buildFile = importYAML ../build.yaml;
    build = lib.lists.head buildFile.include;
    shieldParts = lib.lists.init (lib.strings.splitString "_" build.shield);
    shield = "${lib.strings.concatStringsSep "_" shieldParts}_%PART%";
  in {
    packages = {
      default = self'.packages.firmware;

      firmware = inputs'.zmk-nix.legacyPackages.buildSplitKeyboard {
        name = "firmware";

        src =
          lib.sources.sourceFilesBySuffices
          (inputs.gitignore.lib.gitignoreSource ./..) [
            ".conf"
            ".keymap"
            ".yml"
          ];

        inherit (build) board;
        inherit shield;
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
}
