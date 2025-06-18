{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "ls -A --color=auto";
      grep = "grep --color -n";
    };

    bashrcExtra = builtins.readFile ./bashrcExtra.sh;
  };

}
