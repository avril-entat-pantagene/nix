{ pkgs, lib, ... }:
{
  users.users.avril.packages = with pkgs; [

    home-manager
    bitwarden-desktop
    vesktop
    vlc

    # Paper
    bc
    krita
    libreoffice
    gimp
    vim-full
    kdePackages.kate
    onlyoffice-desktopeditors
    teams-for-linux
    bitwarden-cli

    # Ide
    vscode-fhs

    # Stat
    gpustat
    htop
    kdePackages.filelight

    # tools
    git
    lazygit
    unzip
    sl
    lsd
    zoxide
    bat
    ncdu
    usbutils
    xsel
    xdot
    nixfmt-rfc-style
    gcolor3

    # vcs
    git
    pre-commit
  ];

  virtualisation.virtualbox.host.enable = true;

}
