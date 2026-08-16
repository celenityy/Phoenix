{
  stdenvNoCC,
  lib,
  bashNonInteractive,
  coreutils,
  jq,
  gnused,
  gawk,
  python3,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "phoenix";
  src = ./..;
  nativeBuildInputs = [
    bashNonInteractive
    coreutils
    jq
    gnused
    gawk
  ]
  ++ lib.optionals stdenvNoCC.hostPlatform.isDarwin [ python3 ];

  patchPhase = ''
    sed -i 's|/bin/bash|${bashNonInteractive}/bin/bash|g' ./scripts/build.sh
  '';

  buildPhase = ''
    runHook preBuild

    export PHOENIX_NIX=1

    # external tools used during build
    export PHOENIX_RM="${coreutils}/bin/rm"
    export PHOENIX_MKDIR="${coreutils}/bin/mkdir"
    export PHOENIX_LN="${coreutils}/bin/ln"
    export PHOENIX_TEE="${coreutils}/bin/tee"
    export PHOENIX_DIRNAME="${coreutils}/bin/dirname"
    export PHOENIX_CP="${coreutils}/bin/cp"
    export PHOENIX_SED="${gnused}/bin/sed"
    export PHOENIX_AWK="${gawk}/bin/awk"
    export PHOENIX_CAT="${coreutils}/bin/cat"
    export PHOENIX_JQ="${jq}/bin/jq"
    export PHOENIX_UNAME="${coreutils}/bin/uname"
    ${lib.optionalString stdenvNoCC.hostPlatform.isDarwin ''export PHOENIX_PYTHON="${python3}/bin/python"''}

    patchShebangs ./scripts/*.sh
    ${
      if stdenvNoCC.hostPlatform.isDarwin then
        ''
          ./scripts/build.sh 'osx'
        ''
      else
        ''
          ./scripts/build.sh 'linux'
        ''
    }

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir $out
    ${
      if stdenvNoCC.hostPlatform.isDarwin then
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
