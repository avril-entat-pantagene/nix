{ pkgs, lib, ... }:
{
  users.users.avril.packages = with pkgs; [

    # Stat
    gpustat
    htop
    kdePackages.filelight
    nix-output-monitor

    # tools
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
    ffmpeg_6-full

    gitlab-ci-local

    # vcs
    git
    pre-commit
    gh

  ];

}
