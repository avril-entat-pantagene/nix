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
      cd = "z";
      ls = "lsd -A --group-dirs first";
      tree = "lsd --tree";
      grep = "grep --color -n";
      gf = "git fetch";
      gs = "git status && pre-commit";
      lg = "lazygit";
      c = "code .";
      mktmp = "source mktmp_pkg $@";
    };

    bashrcExtra = builtins.readFile ./bashrcExtra.sh;
  };

}
