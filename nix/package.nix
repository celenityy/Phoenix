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
          cp outputs/osx-silicon/* $out/
          cp -r outputs/osx-silicon/assets $out/assets
          cp -r outputs/osx-silicon/specs $out/specs
        ''
      else
        ''
          cp -r outputs/linux-nonflatpak/assets outputs/linux-nonflatpak/policies/policies.json outputs/linux-nonflatpak/phoenix.cfg outputs/linux-nonflatpak/defaults/pref outputs/linux-nonflatpak/specs $out/
        ''
    }
    install -Dm644 COPYING.txt $out/share/doc/phoenix/COPYING.txt
    install -Dm644 README.md $out/share/doc/phoenix/README.md
    install -Dm644 specs/README.md $out/share/doc/phoenix/specs/README.md

    runHook postInstall
  '';
}
