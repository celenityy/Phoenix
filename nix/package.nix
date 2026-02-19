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

    ${
      if stdenvNoCC.isDarwin then
        ''
          export PHOENIX_OSX_ONLY=1
        ''
      else
        ''
          export PHOENIX_LINUX_ONLY=1
        ''
    }

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
