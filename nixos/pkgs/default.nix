{
  config,
  pkgs,
  lib,
  ...
}:
{
    imports = [
      ./packages.nix
      ./packages-unstable.nix

      ./gistre.nix
      ./info8.nix
    ];
}
