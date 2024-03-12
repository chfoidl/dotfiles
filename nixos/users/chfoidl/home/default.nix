{ inputs, config, system, pkgs, unstablePkgs, ... }:
{
  imports = [
    inputs.configured-nvim.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    ./modules/atuin.nix
    ./modules/git.nix
    #./modules/neovim.nix
    ./modules/brave.nix
    ./modules/waybar.nix
    ./modules/alacritty.nix
    ./modules/lazygit.nix
    #./modules/ripgrep.nix
    ./modules/wofi.nix
    ./modules/hyprland.nix
    ./modules/hyprpaper.nix
    ./modules/hypridle.nix
    ./modules/syncthing.nix
    ./modules/fzf.nix
    ./modules/zsh
  ];

  sops.defaultSopsFile = ../../../secrets/shared/secrets.yaml;
  sops.gnupg.sshKeyPaths = [ "/etc/ssh/ssh_host_rsa_key" ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Env variables.
  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    VISUAL = "nvim";
    DIFFPROG = "nvim -d";
    MANPAGER = "nvim +Man!";
    MANWIDTH = 999;
    NIXOS_OZONE_WL = "1";
    NODE_EXTRA_CA_CERTS = "$HOME/.local/share/mkcert/rootCA.pem";
  };

  # Enable font support.
  fonts.fontconfig.enable = true;

  # User packages.
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    liberation_ttf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    inter

    tree
    wlr-randr
    wl-clipboard
    slack
    figma-linux
    xdg-utils
    whatsapp-for-linux
    eww-wayland

    bruno

    bitwarden
    bitwarden-cli
    anydesk
    atuin
    tmux

    usbutils
    unstablePkgs.hyprlock

    mpv
    vlc
    pavucontrol
    firefox
    dig

    stripe-cli

    (signal-desktop.overrideAttrs (oldAttrs: rec {
      preFixup = oldAttrs.preFixup + ''
        # Start in tray by default
        substituteInPlace $out/share/applications/${oldAttrs.pname}.desktop \
          --replace "%U" "--use-tray-icon --start-in-tray %U"
      '';
    }))

    liquidctl2

    # todo: remove, once home-manager 23.11 is released.
    ripgrep

    mkcert
    inputs.ddev.packages.${system}.ddev
    obsidian
    #inputs.hyprpaper.packages.${system}.hyprpaper

    thunderbird

    (gnome.simple-scan.overrideAttrs (oldAttrs: rec {
      postFixup = ''
        wrapProgram $out/bin/simple-scan --prefix PATH : ${lib.makeBinPath [
          inputs.scanner.packages.${system}.simple-scan-deskew
        ]}
      '';
    }))

    #((softmaker-office.overrideAttrs (oldAttrs: rec {
    #  buildInputs = oldAttrs.buildInputs ++ [
    #    gst_all_1.gstreamer
    #    gst_all_1.gst-plugins-base
    #  ];
    #})).override {
    #  officeVersion = {
    #    version = "1202";
    #    edition = "nx";
    #    hash = "sha256-bTOH0an9WfsA0WQ0gD0CvwEQIrDkRHhWjsyz+07bf8c=";
    #  };
    #})

    (pkgs.writeShellApplication {
      name = "nix-fetch-hash";
      text = ''
        base32=$(${pkgs.nix}/bin/nix-prefetch-url --type sha256 "$1")
        base64=$(${pkgs.nix}/bin/nix hash to-base64 --type sha256 "$base32")

        echo "sha256-$base64"
      '';
    })
  ];

  programs.configured-nvim = {
    enable = true;
    useNightly = false;
  };

  services.gnome-keyring.enable = true;

  # Hyprpaper.
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${system}.hyprpaper;
    preload = [ "~/pictures/wallpapers/wallpaper-1.jpg" ];
    wallpaper = [ ",~/pictures/wallpapers/wallpaper-1.jpg" ];
  };

  # Manage ~/.config.
  xdg.configFile = {
    "waybar".source = ./config/waybar;
    "fontconfig/conf.d/99-default-fonts.conf".text = ''
      <?xml version='1.0'?>

      <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
      <fontconfig>
        <description>Add fonts in the Nix user profile</description>

        <match target="font">
          <edit name="autohint" mode="assign">
            <bool>true</bool>
          </edit>
          <edit name="hinting" mode="assign">
            <bool>true</bool>
          </edit>
          <edit mode="assign" name="hintstyle">
            <const>hintslight</const>
          </edit>
          <edit mode="assign" name="lcdfilter">
            <const>lcddefault</const>
          </edit>
        </match>

        <!-- Default sans-serif font -->
        <match target="pattern">
          <test qual="any" name="family"><string>-apple-system</string></test>
          <!--<test qual="any" name="lang"><string>ja</string></test>-->
          <edit name="family" mode="prepend" binding="same"><string>Inter</string></edit>
        </match>
        <match target="pattern">
          <test qual="any" name="family"><string>Helvetica Neue</string></test>
          <!--<test qual="any" name="lang"><string>ja</string></test>-->
          <edit name="family" mode="prepend" binding="same"><string>Inter</string></edit>
        </match>
        <match target="pattern">
          <test qual="any" name="family"><string>Helvetica</string></test>
          <!--<test qual="any" name="lang"><string>ja</string></test>-->
          <edit name="family" mode="prepend" binding="same"><string>Inter</string></edit>
        </match>
        <match target="pattern">
          <test qual="any" name="family"><string>arial</string></test>
          <!--<test qual="any" name="lang"><string>ja</string></test>-->
          <edit name="family" mode="prepend" binding="same"><string>Inter</string></edit>
        </match>
        <match target="pattern">
          <test qual="any" name="family"><string>sans-serif</string></test>
          <!--<test qual="any" name="lang"><string>ja</string></test>-->
          <edit name="family" mode="prepend" binding="same"><string>Inter</string></edit>
        </match>

        <!-- Default serif fonts -->
        <match target="pattern">
          <test qual="any" name="family"><string>serif</string></test>
          <edit name="family" mode="prepend" binding="same"><string>New York</string></edit>
          <edit name="family" mode="prepend" binding="same"><string>Noto Serif</string></edit>
          <edit name="family" mode="prepend" binding="same"><string>Noto Color Emoji</string></edit>
        </match>

        <!-- Default monospace fonts -->
        <match target="pattern">
          <test qual="any" name="family"><string>monospace</string></test>
          <edit name="family" mode="prepend" binding="same"><string>JetBrainsMono Nerd Font</string></edit>
        </match>

        <!-- Fallback fonts preference order -->
        <alias>
          <family>sans-serif</family>
          <prefer>
            <family>Inter</family>
            <family>Noto Sans</family>
            <family>Noto Color Emoji</family>
            <family>Noto Emoji</family>
            <family>Open Sans</family>
            <family>Droid Sans</family>
            <family>Ubuntu</family>
            <family>Roboto</family>
            <family>NotoSansCJK</family>
            <family>Source Han Sans JP</family>
            <family>IPAPGothic</family>
            <family>VL PGothic</family>
            <family>Koruri</family>
          </prefer>
        </alias>
        <alias>
          <family>serif</family>
          <prefer>
            <family>Noto Serif</family>
            <family>Noto Color Emoji</family>
            <family>Noto Emoji</family>
            <family>Droid Serif</family>
            <family>Roboto Slab</family>
            <family>IPAPMincho</family>
          </prefer>
        </alias>
        <alias>
          <family>monospace</family>
          <prefer>
            <family>JetBrainsMono Nerd Font</family>
            <family>Noto Sans Mono</family>
            <family>Noto Color Emoji</family>
            <family>Noto Emoji</family>
            <family>Inconsolatazi4</family>
            <family>Ubuntu Mono</family>
            <family>Droid Sans Mono</family>
            <family>Roboto Mono</family>
            <family>IPAGothic</family>
          </prefer>
        </alias>

      </fontconfig>
    '';
  };



  # Reload system units on config change. 
  systemd.user.startServices = "sd-switch";
}
