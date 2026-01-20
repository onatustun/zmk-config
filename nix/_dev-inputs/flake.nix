{
  inputs = {
    make-shell = {
      type = "github";
      owner = "nicknovitski";
      repo = "make-shell";
      inputs.flake-compat.follows = "dep_flake-compat";
    };

    git-hooks = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";

      inputs = {
        flake-compat.follows = "dep_flake-compat";
        gitignore.follows = "dep_gitignore";
        nixpkgs.follows = "dep_nixpkgs";
      };
    };

    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      inputs.nixpkgs.follows = "dep_nixpkgs";
    };

    dep_flake-compat = {
      type = "github";
      owner = "edolstra";
      repo = "flake-compat";
      flake = false;
    };

    dep_gitignore = {
      type = "github";
      owner = "hercules-ci";
      repo = "gitignore.nix";
      inputs.nixpkgs.follows = "dep_nixpkgs";
    };

    dep_nixpkgs = {
      type = "tarball";
      url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    };
  };

  outputs = _: {};
}
