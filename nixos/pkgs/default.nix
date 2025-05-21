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
    ];
}
