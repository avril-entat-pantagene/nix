{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  pname = "avrilos";
  version = "1.0";
  src = ./avrilos.tar.gz;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plymouth/themes/
    tar -xvf $src -C $out/share/plymouth/themes/
    substituteInPlace $out/share/plymouth/themes/avrilos/*.plymouth --replace '@ROOT@' "$out/share/plymouth/themes/avrilos/"

    runHook postInstall
  '';
}
