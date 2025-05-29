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
                  "${pkgs.phoenix}/linux/defaults/pref/phoenix-desktop.js";
                environment.etc."firefox/phoenix/userjs".source = "${pkgs.phoenix}/linux/userjs";
                environment.etc."firefox/phoenix/configs".source = "${pkgs.phoenix}/linux/configs";
                programs.firefox.policies =
                  (builtins.fromJSON (builtins.readFile "${pkgs.phoenix}/linux/policies/policies.json")).policies;
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
                sed -i '/general.config.filename/d' build/prefs/phoenix-desktop.js
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
                      cp -r configs/macos $out/configs
                      cp -r userjs/macos $out/userjs
                    ''
                  else
                    ''
                      cp -r policies.json phoenix.cfg prefs configs $out/
                      cp -r userjs/linux $out/userjs
                    ''
                }
                install -Dm644 COPYING $out/share/doc/phoenix/COPYING
                install -Dm644 README.md $out/share/doc/phoenix/README.md
                install -Dm644 userjs/README $out/share/doc/phoenix/userjs/README

                runHook postInstall
              '';
            }
          ) { };

          wrapFirefox =
            browser: args:
            (prev.wrapFirefox browser args).overrideAttrs (old: {
              nativeBuildInputs =
                (old.nativeBuildInputs or [ ])
                ++ (with prev; [
                  zip
                  unzip
                  gnused
                ]);
              buildCommand =
                ''
                  export buildRoot="$(pwd)"
                ''
                + old.buildCommand
                # Allows Search Engine Policies on non-ESR builds,
                # copied from https://hedgedoc.grimmauld.de/s/rVnTq0-Rs#
                + ''
                  if [ -f $out/lib/firefox/browser/omni.ja ]; then
                    pushd $buildRoot
                    unzip $out/lib/firefox/browser/omni.ja -d patched_omni || ret=$?
                    if [[ $ret && $ret -ne 2 ]]; then
                      echo "unzip exited with unexpected error"
                      exit $ret
                    fi
                    rm $out/lib/firefox/browser/omni.ja
                    cd patched_omni
                    sed -i 's/"enterprise_only"\s*:\s*true,//' modules/policies/schema.sys.mjs
                    zip -0DXqr $out/lib/firefox/browser/omni.ja * # potentially qr9XD
                    popd
                  fi
                '';
            });

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
