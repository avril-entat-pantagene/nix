{ stdenv, fetchurl }:
  stdenv.mkDerivation rec {
    pname = "plymouth-vinyl-theme";
    version = "1.0";
    src = ./vinyl.tar.gz;

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/plymouth/themes/
      tar -xvf $src -C $out/share/plymouth/themes/
      substituteInPlace $out/share/plymouth/themes/vinyl/*.plymouth --replace '@ROOT@' "$out/share/plymouth/themes/vinyl/"

      runHook postInstall
    '';
  }