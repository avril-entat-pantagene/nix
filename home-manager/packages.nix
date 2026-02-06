{
  config,
  pkgs,
  lib,
  ...
}:
# The home.packages option allows you to install Nix packages into your
# environment.
{
  home.packages = [

    pkgs.dotacat
    pkgs.fastfetch
    pkgs.zsh-autocomplete

    (pkgs.writeShellScriptBin "fetch" (builtins.readFile ./scripts/fetch.sh))
    (pkgs.writeShellScriptBin "mktmp_pkg" (builtins.readFile ./scripts/mktmp.sh))
  ];
}
