{inputs, ...}: {
  perSystem = {
    self',
    inputs',
    lib,
    ...
  }: {
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

        board = "nice_nano_v2";
        shield = "cradio_%PART%";
        zephyrDepsHash = "sha256-SHiCGErcstMH9EbvbQROXIhxFEbMf3AungYu5YvqMEg=";

        meta = {
          description = "ZMK firmware";
          license = lib.licenses.mit;
          platforms = lib.platforms.all;
        };
      };

      flash = inputs'.zmk-nix.packages.flash.override {inherit (self'.packages) firmware;};
      inherit (inputs'.zmk-nix.packages) update;
    };
  };
}
