{ pkgs, lib, ... }:
{

  services.udev.packages = [
    pkgs.usb-blaster-udev-rules
    pkgs.stlink
    pkgs.cdrtools
    pkgs.dvdplusrwtools
  ];

  hardware.saleae-logic.enable = true;

  environment.systemPackages = with pkgs; [
    # Serial
    minicom
    screen

    # Embedded
    arduino
    arduino-cli
    arduino-ide

    # Elec
    kicad

    # STM32
    stm32cubemx
    stlink
    stlink-gui
    stlink-server
    gcc
    gdb
    cmake

    # Others
    python314

    # VHDL
    ghdl-llvm
    surfer
    (quartus-prime-lite.override {
      supportedDevices = [
        "Cyclone V"
        "MAX 10 FPGA"
      ];
    })
  ];

  # quartus-prime-lite
  environment.variables = {
    LM_LICENSE_FILE = "/home/avril/nix/licences/LR-157058_License.dat";
    MGLS_LICENSE_FILE = "/home/avril/nix/licences/LR-157058_License.dat";
  };

  # IOT
  services = {
    node-red = {
      enable = true;
      openFirewall = true;
      withNpmAndGcc = true;
    };
    mosquitto.enable = true;
  };

  # Libvirtd
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    qemu = {
      swtpm.enable = true;
    };
  };

  programs.stm32cubeide = {
    enable = true;
    # Optional: disable J-Link rules if you don't use SEGGER probes
    # enableJlink = false;
  };

}
