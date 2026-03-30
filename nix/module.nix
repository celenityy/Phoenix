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
      environment.variables = {
        MOZ_CRASHREPORTER = "";
        MOZ_CRASHREPORTER_DISABLE = 1;
        MOZ_CRASHREPORTER_NO_REPORT = 1;
        MOZ_CRASHREPORTER_URL = "data;";
        MOZ_DISABLE_ASAN_REPORTER = 1;
        MOZ_ENABLE_WAYLAND = 1;
        PHOENIX_HOST_NIX = 1;
        SSLKEYLOGFILE = "";
      };
      programs.firefox.policies =
        (builtins.fromJSON (builtins.readFile "${pkgs.phoenix}/policies.json")).policies;
      nixpkgs.overlays = [
        (import ./overlay.nix)
        (
          final: prev:
          builtins.listToAttrs (
            map (p: lib.nameValuePair p (final.withPhoenix prev.${p})) cfg.firefoxPackages
          )
        )
      ];
    };
}
