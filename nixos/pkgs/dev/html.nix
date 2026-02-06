{ pkgs, lib, ... }:
{
  users.users.avril.packages = with pkgs; [

    # Js
    nodejs_24
    yarn

    sqlite

  ];

}
