{
  description = "stlink-server - ST-Link GDB server for STM32 microcontrollers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        version = "2.1.1-5";

        stlink-server = pkgs.stdenv.mkDerivation {
          pname = "stlink-server";
          inherit version;

          # The binary is already extracted in stm32link-extract/
          src = ./stm32link-extract;

          nativeBuildInputs = with pkgs; [
            autoPatchelfHook
            makeWrapper
          ];

          buildInputs = with pkgs; [
            libusb1
            stdenv.cc.cc.lib # glibc
          ];

          dontConfigure = true;
          dontBuild = true;

          installPhase = ''
            runHook preInstall

            # Install the binary
            mkdir -p $out/bin
            install -m 0755 stlink-server $out/bin/stlink-server

            runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "ST-Link GDB server for STM32 microcontrollers";
            homepage = "https://www.st.com/en/development-tools/stm32cubeide.html";
            license = licenses.unfree;
            platforms = [ "x86_64-linux" ];
            mainProgram = "stlink-server";
            sourceProvenance = [ sourceTypes.binaryNativeCode ];
          };
        };

      in
      {
        packages = {
          default = stlink-server;
          stlink-server = stlink-server;
        };

        # Overlay for use in other flakes
        overlays.default = final: prev: {
          stlink-server = stlink-server;
        };
      }
    )
    // {
      # Overlay (system-independent entry point)
      overlays.default = final: prev: {
        stlink-server = self.packages.${prev.system}.default;
      };
    };
}
