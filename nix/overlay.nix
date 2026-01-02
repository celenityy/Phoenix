final: prev: {
  phoenix = final.callPackage ./package.nix { };

  withPhoenix =
    firefoxPackage:
    firefoxPackage.override {
      extraPoliciesFiles = [ "${final.phoenix}/policies.json" ];
      extraPrefsFiles = [ "${final.phoenix}/phoenix.cfg" ];
    };
}
