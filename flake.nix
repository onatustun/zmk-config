{
  description = "ZMK config";

  nixConfig = rec {
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-substituters = extra-substituters;
    extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];

    extra-experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  inputs = {
    nixpkgs = {
      type = "tarball";
      url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    };

    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "default";
    };

    import-tree = {
      type = "github";
      owner = "vic";
      repo = "import-tree";
    };

    zmk-nix = {
      type = "github";
      owner = "lilyinstarlight";
      repo = "zmk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./nix);
}
