{ pkgs, lib, ... }:
{
  users.users.avril.packages = with pkgs; [

    home-manager
    bitwarden-desktop
    discord
    vlc
    tor-browser
    google-chrome

    cmake
    gbenchmark
    tbb
    SDL2

    # Paper
    bc
    krita
    libreoffice
    gimp
    vim-full
    kdePackages.kate
    texlive.combined.scheme-full
    onlyoffice-desktopeditors

    # Ide
    vscode-fhs
    jetbrains-toolbox

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

    # ACDC
    dotnet-sdk_7
    dotnet-aspnetcore_7
    dotnet-runtime_7
    dotnetCorePackages.sdk_7_0_3xx-bin
    dotnetCorePackages.sdk_8_0-bin

    # Js
    nodejs_22
    yarn

    # Java
    maven
    jdk21_headless

    #SQL
    postgresql

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

    # Tiger
    boost
    re-flex
    bison
    libxslt
    libtool
    perl
    swig4
    clang_multi
    libllvm
    multiStdenv.cc
    lldb
    libcxx

    # lcov dependencies
    perlPackages.JSON
    perlPackages.PerlIOgzip

    # vcs
    git
    pre-commit
    subversion
    tig

    # EPITA Net.
    gns3-gui
    gns3-server
    inetutils
    pkgsi686Linux.dynamips
    tigervnc
    vpcs
    aria2

    # rust
    rustc
    rustup
    rustfmt

    (jetbrains.rider.overrideAttrs (attrs: {
      postInstall =
        (attrs.postInstall or "")
        + lib.optionalString (stdenv.hostPlatform.isLinux) ''
          (
            cd $out/rider

            ls -d $PWD/plugins/cidr-debugger-plugin/bin/lldb/linux/*/lib/python3.8/lib-dynload/* |
            xargs patchelf \
              --replace-needed libssl.so.10 libssl.so \
              --replace-needed libcrypto.so.10 libcrypto.so \
              --replace-needed libcrypt.so.1 libcrypt.so

            for dir in lib/ReSharperHost/linux-*; do
              rm -rf $dir/dotnet
              ln -s ${dotnet-sdk_7.unwrapped}/share/dotnet $dir/dotnet 
            done
          )
        '';
    }))

  ];

  virtualisation.virtualbox.host.enable = true;

  environment.variables = {
    ACLOCAL_PATH = "${pkgs.autoconf-archive}/share/aclocal:${pkgs.autoconf}/share/aclocal:${pkgs.automake}/share/aclocal";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
    "aspnetcore-runtime-7.0.20"
    "dotnet-runtime-7.0.20"
    "dotnet-sdk-7.0.317"
  ];

}
