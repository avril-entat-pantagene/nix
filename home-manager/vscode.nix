{ pkgs ? import <nixpkgs> {} }:

let
  buildInputs = with pkgs; [
    dotnet-sdk_7
    vscode
  ];
in
pkgs.mkShell {
  name = "dotnet-env";
  buildInputs = buildInputs;
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath buildInputs}
  '';
}