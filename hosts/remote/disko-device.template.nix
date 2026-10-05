{ config, lib, pkgs, ... }:

{
  disko.devices.disk.main.device = "{{DEVICE}}";
}