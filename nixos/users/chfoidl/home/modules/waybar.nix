{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      # Enable experimental flag to support wlr/workspaces module.
      mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
      # Make click on workspace work.
      patches = (oa.patches or []) ++ [
        (pkgs.fetchpatch {
          name = "fix waybar hyprctl";
          url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
          sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
        })
      ];
    });
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "System Tray";
      Wants = [ "graphical-session-pre.target" ];
    };
  };
}
