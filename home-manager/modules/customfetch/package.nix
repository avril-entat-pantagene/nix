{ pkgs, ... }:

let
  # On importe votre packaging local en lui passant les pkgs de NixOS
  customfetch-pkg = pkgs.callPackage ./default.nix { };
in
{
  # 1. On installe le paquet pour l'utilisateur
  home.packages = [
    customfetch-pkg
  ];

  # 2. On génère le fichier de configuration du thème dans .config/customfetch/config.toml
  xdg.configFile."customfetch/config.toml".source = ./config.toml;
  xdg.configFile."customfetch/logo.txt".source = ./logo.txt;
}
