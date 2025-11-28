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
              firefoxPackages = lib.mkOption {
                type = lib.types.listOf lib.types.str;
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
                  "${pkgs.phoenix}/pref/phoenix-desktop.js";
                environment.etc."firefox/phoenix/userjs".source = "${pkgs.phoenix}/userjs";
                environment.etc."firefox/phoenix/configs".source = "${pkgs.phoenix}/configs";
                environment.etc."firefox/phoenix/assets".source = "${pkgs.phoenix}/assets";
                programs.firefox.policies =
                  (builtins.fromJSON (builtins.readFile "${pkgs.phoenix}/policies.json")).policies;
                nixpkgs.overlays = [
                  self.overlays.default
                  (
                    final: prev:
                    builtins.listToAttrs (
                      map (p: lib.nameValuePair p (final.withPhoenix prev.${p})) cfg.firefoxPackages
                    )
                  )
                ];
              };
          };
      };

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

      overlays = {
        default = final: prev: {
          phoenix = final.callPackage (
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
                sed -i '/general.config.filename/d' build/phoenix-unified.js
                ./build/build.sh

                runHook postBuild
              '';
              installPhase = ''
                runHook preInstall

                mkdir $out
                ${
                  if stdenvNoCC.isDarwin then
                    ''
                      cp macos/* $out/
                      cp -r macos/assets $out/assets
                      cp -r macos/configs $out/configs
                      cp -r macos/userjs $out/userjs
                    ''
                  else
                    ''
                      cp -r linux/assets linux/policies/policies.json linux/phoenix.cfg linux/defaults/pref linux/configs $out/
                      cp -r linux/userjs $out/userjs
                    ''
                }
                install -Dm644 linux/COPYING.txt $out/share/doc/phoenix/COPYING.txt
                install -Dm644 linux/README.md $out/share/doc/phoenix/README.md
                install -Dm644 linux/userjs/README.md $out/share/doc/phoenix/userjs/README.md

                runHook postInstall
              '';
            }
          ) { };

          withPhoenix =
            firefoxPackage:
            firefoxPackage.override {
              extraPoliciesFiles = [ "${final.phoenix}/policies.json" ];
              extraPrefsFiles = [ "${final.phoenix}/phoenix.cfg" ];
            };
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
