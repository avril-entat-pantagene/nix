{
  pkgs,
  inputs,
  lib,
  config,
  outputs,
  ...
}: {
  
  programs.bash.shellAliases = {
    teub = "tree";
  };

}

