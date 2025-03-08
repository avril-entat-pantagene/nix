{
  pkgs,
  inputs,
  lib,
  config,
  outputs,
  ...
}:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.baptiste.shell = pkgs.zsh;
}
