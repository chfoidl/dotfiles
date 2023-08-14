{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.hyprpaper;
  configFile = builtins.concatStringsSep "\n\n" ([
    "${builtins.concatStringsSep "\n" (map (item: "preload = " + item) cfg.preload)}"
    "${builtins.concatStringsSep "\n" (map (item: "wallpaper = " + item) cfg.wallpaper)}"
  ]);
in {
  options = {
    services.hyprpaper = {
      enable = mkEnableOption "Hyprpaper";

      package = mkOption {
        type = types.package;
        default = pkgs.hyprpaper;
        defaultText = literalExpression "pkgs.hyprpaper";
        description = "The hyprpaper package to use.";
      };

      preload = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "/path/to/image.png" "/path/to/next_image.png" ];
        description = "List of image paths to preload.";
      };

      wallpaper = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "monitor1,/path/to/image.png" "monitor2,/path/to/next_image.png" ];
        description = "List of wallpapers to set on specified monitor.";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "services.hyprpaper" pkgs
        lib.platforms.linux)
    ];

    home.packages = [ cfg.package ];

    systemd.user.services.hyprpaper = {
      Unit = {
        Description = "Hyprpaper";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "hyprland-session.target" ];
      };

      Install.WantedBy = [ "hyprland-session.target" ];

      Service = {
        ExecStart =
          "${cfg.package}/bin/hyprpaper";
        Restart = "always";
      };
    };

    xdg.configFile."hypr/hyprpaper.conf".text = configFile;
  };
}

