# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowBroken = true; # TODO REMOVE
  # Allow unfree packages && NVIDIA
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  nix.settings.experimental-features = [ "nix-command flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "oss_nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # GPU fix
  hardware.nvidia = {
    package = pkgs.nvidiaPackages.stable;  # or nvidiaPackages.latest for the latest driver
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };
  hardware.opengl.enable = true;  # Enables OpenGL support

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:4:0:0";
  };

  # Multi boot
  specialisation = {
  fullperf.configuration = {
    system.nixos.tags = [ "fullperf" ];
    hardware.nvidia = {
      prime.offload.enable = lib.mkForce false;
      prime.offload.enableOffloadCmd = lib.mkForce false;
      prime.sync.enable = lib.mkForce true;
    };
  };
};





  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  hardware.bluetooth.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.baptiste = {
    isNormalUser = true;
    description = "Baptiste ENTAT-PANTAGENE";
    extraGroups = [ "networkmanager" "wheel" "audio" "plugdev" "docker"];
    packages = with pkgs; [
    kdePackages.kate
    krita
    kdePackages.kleopatra
    vesktop
    google-chrome
    vscodium-fhs
    vlc

    # rider
    dotnet-sdk_7
    jetbrains.rider

    # tools
    git
    gh
    unzip
    sl

    # -- Game --
    lunar-client

    # --- SDL ---
    # v1
    SDL
    SDL_Pango
    SDL_gfx
    SDL_image
    SDL_mixer
    SDL_net
    SDL_ttf

    # v2
    SDL2
    SDL2_image
    SDL2_mixer
    SDL2_net
    SDL2_ttf

    libGLU

    alsa-lib
    libpulseaudio
    # --- SDL ---

    # build systems
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
      criterion
      gtest
      gcovr

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

      # lcov dependencies
      perlPackages.JSON
      perlPackages.PerlIOgzip

      # vcs
      git
      pre-commit
      subversion
      tig

      # steam
      bumblebee
      glxinfo

    ];
  };

  programs.java = {
      enable = true;
      package = pkgs.jdk;
    };



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tree
  ];

  programs.direnv.enable = true;

  #Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # -- steam ---
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # --------------------------------------------------------------
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
