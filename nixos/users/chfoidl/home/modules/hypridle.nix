{ inputs, pkgs, unstablePkgs, ... }: {
  services.hypridle = {
    enable = true;

    ignoreDbusInhibit = false;

    listeners = [
      # Screenlock
      {
        timeout = 600;
        onTimeout = "${unstablePkgs.hyprlock}/bin/hyprlock";
      }

      # DPMS
      {
        timeout = 660;
        onTimeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
