{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/user.nix
    ./disko.nix
    
    ./hardware-configuration.nix
    ./disko-device.nix
  ];

  config = {
    boot.loader.grub.enable = true;
    networking.hostName = "remote";
    networking.networkmanager.enable = true;
    system.stateVersion = "26.05";

    environment.systemPackages = with pkgs; [
      git
      curl
      wget

      cloudflared
      ttyd
    ];

    services.ttyd = {
      enable = true;
      port = 8080;
      writeable = true;
    };

    systemd.services.cloudflared = {
      enable = true;
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      description = "Cloudflared remotely managed tunnel";

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.cloudflared}/bin/cloudflared --no-autoupdate tunnel run --token-file /etc/cloudflared/token";
        Restart = "on-failure";
      };
    };
  };
}