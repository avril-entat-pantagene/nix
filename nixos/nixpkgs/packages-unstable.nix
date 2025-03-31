{ pkgs-unstable, lib, ... }:
{

  users.users.baptiste.packages = with pkgs-unstable; [
    home-manager

    vesktop

    # -- Browser --
    google-chrome
    tor-browser

    # -- Game --
    lunar-client
  ];

}
