{ config, lib, pkgs, ... }:

{
  users.users.gstoney = {
    isNormalUser = true;

    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];

    initialPassword = "changeme";

    packages = with pkgs; [
      neovim
      stow
    ];
  };
}