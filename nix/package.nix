{
  stdenvNoCC,
  python3,
  jq,
  zip,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "phoenix";
  src = ./..;
  nativeBuildInputs = [
    python3
    jq
    zip
  ];
  buildPhase = ''
    runHook preBuild

    export PHOENIX_NIX=1

    patchShebangs ./scripts/*.sh
    sed -i '/general.config.filename/d' phoenix-unified.cfg
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
