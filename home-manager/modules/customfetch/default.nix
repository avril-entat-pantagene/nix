{
  lib,
  stdenv,
  fetchFromGitHub,
  bash,
  gettext,
  cmake,
  pkg-config,
  tomlplusplus,
  fmt,
}:

stdenv.mkDerivation rec {
  pname = "fetch";
  version = "2.0.0-beta1"; # Vous pouvez adapter la version ou le commit

  src = fetchFromGitHub {
    owner = "Toni500github";
    repo = "customfetch";
    rev = "v${version}";
    # La valeur hash ci-dessous est fictive, Nix affichera le bon hash lors du premier build
    hash = "sha256-RgTEhoDMe0qoH+0fB0j+VJ7NIdrs1fHMOPHAJmv2O3s=";
  };

  nativeBuildInputs = [
    bash
    gettext
    cmake
    pkg-config
  ];

  postPatch = ''
    patchShebangs scripts
  '';

  postInstall = ''
    if [ -x "$out/bin/customfetch" ]; then
      ln -s "$out/bin/customfetch" "$out/bin/fetch"
    fi
  '';

  # Ajout des dépendances (le projet utilise fmt et toml++)
  buildInputs = [
    fmt
    tomlplusplus
  ];

  # Si vous souhaitez désactiver l'application GUI (GTK3) comme indiqué dans le Makefile
  cmakeFlags = [
    "-DGUI_APP=OFF"
  ];

  meta = with lib; {
    description = "A modular information fetching tool, focused on performance and customizability";
    homepage = "https://github.com/Toni500github/customfetch";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
