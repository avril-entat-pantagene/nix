{ pkgs, lib, ... }:
{

  users.users.baptiste.packages = with pkgs; [
    home-manager
    kdePackages.kate
    kdePackages.plasma-browser-integration
    krita
    kdePackages.kleopatra
    vesktop
    google-chrome
    vscode-fhs
    vlc
    kitty
    jetbrains.clion
    jetbrains.idea-ultimate

    # Stat
    mission-center
    gpustat

    # tools
    git
    gh
    unzip
    sl
    ncdu

    # nix
    cachix
    devenv

    # -- Game --
    lunar-client

    # build systems
    criterion
    autoconf
    autoconf-archive
    automake
    cmake
    gnumake
    meson
    ninja

    # compilers
    # Putting gcc before clang means that `which cc` will be `gcc` instead of
    # `clang`
    gcc
    # gcc-unwrapped with lower priority than gcc so `gcov` is available and
    # `gcc` is still wrapped
    (lib.setPrio (gcc.meta.priority + 1) gcc-unwrapped)

    clang_12
    llvmPackages_12.llvm
    llvmPackages_12.lld

    # testing frameworks

    gtest
    gcovr
    python311Full
    python311Packages.pytest

    # misc
    bintools
    capstone
    check
    checkbashisms
    clang-tools
    ctags
    dash
    doxygen
    fakeroot
    flex
    gdb
    lcov
    ltrace
    pkg-config
    readline
    rr
    shellcheck
    strace
    tk
    valgrind
    bear

    # lcov dependencies
    perlPackages.JSON
    perlPackages.PerlIOgzip

    # vcs
    git
    pre-commit
    subversion
    tig

    # steam
    #bumblebee
    #glxinfo

    # EPITA Net.
    gns3-gui
    gns3-server
    inetutils
    pkgsi686Linux.dynamips
    tigervnc
    vpcs
    aria2

    xdot
    nixfmt-rfc-style

  ];

  virtualisation.virtualbox.host.enable = true;

  environment.variables = {
    ACLOCAL_PATH = "${pkgs.autoconf-archive}/share/aclocal:${pkgs.autoconf}/share/aclocal:${pkgs.automake}/share/aclocal";
  };

}
