{ pkgs, lib, ... }:
{
  users.users.avril.packages = with pkgs; [

    home-manager

    vesktop
    vlc
    google-chrome

    # Paper
    bc
    libreoffice
    gimp
    vim-full
    kdePackages.kate
    onlyoffice-desktopeditors
    darktable
  ];

}
