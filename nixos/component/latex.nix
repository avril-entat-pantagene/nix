{ pkgs, lib, ... }:
{

  users.users.avril.packages = with pkgs; [

    #texliveFull
    texlive.combined.scheme-full

  ];
}
