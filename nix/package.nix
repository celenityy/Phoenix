{
  stdenvNoCC,
  jq,
  gawk,
  gnused,
  python3,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "phoenix";
  src = ./..;
  nativeBuildInputs = [
    jq
    gawk
    gnused
    python3
  ];
  buildPhase = ''
    runHook preBuild

    export PHOENIX_NIX=1
    export PHOENIX_AWK="${gawk}/bin/awk"
    export PHOENIX_SED="${gnused}/bin/sed"
    export PHOENIX_PYTHON="${python3}/bin/python"

    patchShebangs ./scripts/*.sh
    ./scripts/build.sh

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir $out
    ${
      if stdenvNoCC.isDarwin then
        ''
          cp outputs/osx/* $out/
          cp -r outputs/osx/assets $out/assets
          cp -r outputs/osx/specs $out/specs
        ''
      else
        ''
          cp -r outputs/linux/assets outputs/linux/policies/policies.json outputs/linux/phoenix.cfg outputs/linux/defaults/pref outputs/linux/specs $out/
        ''
    }
    install -Dm644 COPYING.txt $out/share/doc/phoenix/COPYING.txt
    install -Dm644 README.md $out/share/doc/phoenix/README.md
    install -Dm644 specs/README.md $out/share/doc/phoenix/specs/README.md

    runHook postInstall
  '';
}
