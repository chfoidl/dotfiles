{ inputs, system, pkgs, lib, config, ... }:
let
  syncthingtray-pkg = config.services.syncthing.tray.package;
in {
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  systemd.user.services.syncthingtray.Service = {
    ExecStart = lib.mkForce "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/sleep 5; ${syncthingtray-pkg}/bin/syncthingtray'";
    Environment = "QT_QPA_PLATFORM=wayland";
  };
}
