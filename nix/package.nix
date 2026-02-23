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
    sed -i '/general.config.filename/d' build-resources/phoenix-unified.js
    ./scripts/build.sh

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir $out
    ${
      if stdenvNoCC.isDarwin then
        ''
          cp osx/* $out/
          cp -r osx/assets $out/assets
          cp -r osx/configs $out/configs
          cp -r osx/userjs $out/userjs
        ''
      else
        ''
          cp -r linux/assets linux/policies/policies.json linux/phoenix.cfg linux/defaults/pref linux/configs $out/
          cp -r linux/userjs $out/userjs
        ''
    }
    install -Dm644 COPYING.txt $out/share/doc/phoenix/COPYING.txt
    install -Dm644 README.md $out/share/doc/phoenix/README.md
    install -Dm644 build-resources/specs/README.md $out/share/doc/phoenix/userjs/README.md

    runHook postInstall
  '';
}
