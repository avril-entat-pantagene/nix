{
  description = "Flake for LASY";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, rust-overlay }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.${system}.default =
        with pkgs;
        mkShell (rec {
          buildInputs = [
            # Ada
            ada
            alire
            gnat15
            gprbuild
            glibc
            binutils
            libz

            # Rust
            rust-analyzer
            rustc
            llvmPackages_latest.lldb
          ];

          shellHook = ''
            export LIBRARY_PATH=${pkgs.lib.makeLibraryPath buildInputs}
            export C_INCLUDE_PATH=${glibc}/include
            export CPLUS_INCLUDE_PATH=${glibc}/include
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH
          '';
        });
    };
}