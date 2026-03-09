{ pkgs, ... }:
{

  services.mongodb = {
    package = pkgs.mongodb-ce;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    mongosh
    mongodb-tools

    elasticsearch
  ];

}
