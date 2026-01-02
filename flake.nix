{
  description = "Phoenix: a suite of configurations & advanced modifications for Mozilla Firefox, designed to put the user first - with a focus on privacy, security, freedom, functionality, & usability.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      nixosModules.default = import ./nix/module.nix;

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
        in
        rec {
          default = phoenix;
          inherit (pkgs) phoenix;
          firefox = pkgs.withPhoenix pkgs.firefox;
        }
      );

      overlays.default = import ./nix/overlay.nix;

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
