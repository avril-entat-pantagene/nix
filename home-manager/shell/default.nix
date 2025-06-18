{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./bash.nix
    ./kitty.nix
    ./starship.nix
    ./zsh.nix
  ];

}
