{ pkgs, lib, ... }:
{
  users.users.avril.packages = with pkgs; [

    # Ide
    vscode-fhs
    
  ];

}
