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
      nixosModules = {
        default =
          {
            pkgs,
            config,
            lib,
            ...
          }:
          {
            options.programs.firefox.phoenix = {
              enable =
                lib.mkEnableOption "Enable privacy & security hardening of Firefox using the Phoenix configs"
                // {
                  default = true;
                };
              package = lib.mkOption {
                type = lib.types.package;
                default = self.packages.${pkgs.system}.phoenix;
                description = "The Phoenix package to use.";
                defaultText = lib.literalExpression "phoenix";
              };
              firefoxPackages = lib.mkOption {
                type = lib.types.listOf lib.types.string;
                default = [ "firefox" ];
                description = "The name of Firefox packages of current pkgs to patch with phoenix config and policy.";
              };
            };
            config =
              let
                cfg = config.programs.firefox.phoenix;
              in
              lib.mkIf cfg.enable {
                assertions = [
                  {
                    assertion = !pkgs.stdenv.isDarwin;
                    message = "Phoenix module has not been ported to nix-darwin yet. Contributions welcomed.";
                  }
                ];
                environment.etc."firefox/defaults/pref/phoenix-desktop.js".source =
                  "${cfg.package}/prefs/phoenix-desktop.js";
                environment.etc."firefox/phoenix/userjs".source = "${cfg.package}/userjs";
                environment.etc."firefox/phoenix/configs".source = "${cfg.package}/configs";
                nixpkgs.overlays = [
                  (
                    self: super:
                    builtins.listToAttrs (
                      map (
                        p:
                        lib.nameValuePair p (
                          super.${p}.override {
                            extraPoliciesFiles = [ "${cfg.package}/policies.json" ];
                            extraPrefsFiles = [ "${cfg.package}/phoenix.cfg" ];
                          }
                        )
                      ) cfg.firefoxPackages
                    )
                  )
                ];
              };
          };
      };

      packages = forAllSystems (system: rec {
        default = phoenix;
        phoenix = nixpkgs.legacyPackages.${system}.callPackage (
          {
            stdenvNoCC,
            python3,
            jq,
            zip,
            ...
          }:
          stdenvNoCC.mkDerivation {
            name = "phoenix";
            src = ./.;
            nativeBuildInputs = [
              python3
              jq
              zip
            ];
            buildPhase = ''
              runHook preBuild

              patchShebangs ./build/*.sh
              ./build/build.sh

              runHook postBuild
            '';
            installPhase = ''
              runHook preInstall

              mkdir $out
              ${
                if stdenvNoCC.isDarwin then
                  ''
                    cp $src/macos/* $out/
                    cp -r $src/configs/macos $out/configs
                    cp -r $src/userjs/macos $out/userjs
                  ''
                else
                  ''
                    cp -r $src/policies.json $src/phoenix.cfg $src/prefs $src/configs $out/
                    cp -r $src/userjs/linux $out/userjs
                  ''
              }
              install -Dm644 $src/COPYING $out/share/doc/phoenix/COPYING
              install -Dm644 $src/README.md $out/share/doc/phoenix/README.md
              install -Dm644 $src/userjs/README.md $out/share/doc/phoenix/userjs/README.md

              runHook postInstall
            '';
          }
        ) { };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
