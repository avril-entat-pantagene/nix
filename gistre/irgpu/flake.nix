{
  description = "GPGPU course environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      inherit (pkgs.lib) attrValues;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "cuda-env-shell";
        buildInputs = with pkgs; [
          # C Stuff
          gcc
          cmake
          clang-tools
          pkg-config

          # CUDA deps
          cudaPackages.cudatoolkit
          cudaPackages.cuda_nvcc
          cudaPackages.cudnn
          cudaPackages.cuda_cudart
          cudaPackages.cuda_nvprof

          # CUDA analysis tools
          cudaPackages.nsight_systems
          cudaPackages.cuda_nvprof

          # GStreamer
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-ugly
          gst_all_1.gst-plugins-bad
          gst_all_1.gst-plugins-good

          # Xorg deps
          libXi
          libXmu
          libXext
          libX11
          libXv
          libXrandr

          gbenchmark
          gperf

          freeglut
          libGLU
          libGL

          libpng
          pngpp
          tbb
        ];
        shellHook = with pkgs; ''
          export LD_LIBRARY_PATH=${cudaPackages.cuda_nvprof.lib}/lib:/run/opengl-driver/lib:${pkgs.linuxPackages.nvidia_x11}/lib:$LD_LIBRARY_PATH
          export CUDAHOSTCXX=${pkgs.gcc}/bin/g++
          export NVCC_PREPEND_FLAGS="-ccbin ${pkgs.gcc}/bin/g++"
          export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}

          export EXTRA_LDFLAGS="-L${pkgs.linuxPackages.nvidia_x11}/lib"
        '';
      };
    };
}