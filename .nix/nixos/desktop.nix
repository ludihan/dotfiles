{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./default.nix
    ../hardware/desktop.nix
  ];
  networking.hostName = lib.mkForce "nixos-desktop";
  services.logind.settings.Login.HandlePowerKey = "ignore";
  services.logind.settings.Login.HandleSuspendKey = "ignore";
  services.logind.settings.Login.HandleHibernateKey = "ignore";
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
}
