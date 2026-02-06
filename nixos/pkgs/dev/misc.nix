{ pkgs, lib, ... }:
{
  users.users.avril.packages = with pkgs; [
    python3

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

    # GISTRE
    # stm32cubemx
  ];

}
