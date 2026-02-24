{ pkgs, lib, ... }:
{

  services.udev.packages = [ pkgs.usb-blaster-udev-rules pkgs.stlink pkgs.cdrtools pkgs.dvdplusrwtools ];

  environment.systemPackages = with pkgs; [
    # Serial
    pkgs.screen

    # Embedded
    arduino
    arduino-cli
    arduino-ide
    saleae-logic-2

    # Elec
    kicad

    # STM32
    stm32cubemx
    stlink
    stlink-gui
    stlink-server
    gcc
    gdb
  ];

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
