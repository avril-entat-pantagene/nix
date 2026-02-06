{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./dev/default.nix
    ./packages.nix
    ./packages-unstable.nix
    ./tools.nix
    ./paper.nix
  ];
}
