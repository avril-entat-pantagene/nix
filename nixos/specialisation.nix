{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  specialisation = {
    steamed = {
      inheritParentConfig = true;

      configuration = {

        system.nixos.tags = [ "steamed" ];
        users.users.steamed = {
          isNormalUser = true;
          uid = 1002;
          extraGroups = [
            "networkmanager"
            "video"
          ];
        };
        services.xserver.displayManager.autoLogin = {
          enable = true;
          user = "steamed";
        };

        environment.systemPackages = with pkgs; [
          steam
        ];

        systemd.user.services.steam = {
          enable = true;
          description = "Open Steam in the background at boot";
          serviceConfig = {
            ExecStart = "${pkgs.steam}/bin/steam -nochatui -nofriendsui -silent %U";
            wantedBy = [ "graphical-session.target" ];
            Restart = "on-failure";
            RestartSec = "5s";
          };
        };
      };
    };
  };
}
