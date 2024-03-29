{ inputs, config, pkgs, unstablePkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.hyprland.nixosModules.default
    inputs.sops-nix.nixosModules.sops
  ];

  # SOPS
  sops.defaultSopsFile = ../../secrets/shared/secrets.yaml;
  sops.gnupg.sshKeyPaths = [ "/etc/ssh/ssh_host_rsa_key" ];
  sops.secrets."wg-quick/ush/configFile" = {
    sopsFile = ./secrets.yaml;
  };

  #programs.hyprland.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    sysroot = {
      device = "/dev/disk/by-uuid/c39fdac9-790b-4d05-a85b-00e5360ea9ed";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  console.keyMap = "de";

  powerManagement = {
    cpuFreqGovernor = "performance";
  };

  networking.useDHCP = false;
  networking.enableIPv6 = false;
  systemd.network.enable = true;
  systemd.network.networks = {
    "10-lan" = {
      matchConfig.Name = "eno*";
      networkConfig.DHCP = "ipv4";
    };
  };

  networking.wg-quick.interfaces = {
    wg_ush = {
      autostart = true;
      configFile = "/run/secrets/wg-quick/ush/configFile";
    };
  };

  networking.wireless.iwd.enable = true;

  time.timeZone = "Europe/Vienna";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  security.polkit.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    git
    binutils
    pciutils
    gcc
    libressl
    cifs-utils
    pinentry-curses
    polkit_gnome
    gnome.adwaita-icon-theme

    davinci-resolve
    ffmpeg
    obs-studio
  ];

  programs.dconf.enable = true;

  # Filesystem setup
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  programs.zsh.enable = true;

  nix = {
    extraOptions = ''experimental-features = nix-command flakes'';
    package = pkgs.nixUnstable;
  };

  hardware.bluetooth.enable = true;

  hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
		extraPackages = with pkgs; [
			amdvlk
			vaapiVdpau
			libvdpau-va-gl
      rocmPackages.clr.icd
		];
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless.enable = true;
      package = unstablePkgs.docker_24;
    };
  };

  services.avahi = {
    enable = true;
    nssmdns = true;  # printing
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = ["docker0"];
    allowedTCPPorts = [ 3000 3001 3002 3003 3004 3005 9003 ];

    allowedTCPPortRanges = [
      { from = 30000; to = 60000; }
    ];
    allowedUDPPortRanges = [
      { from = 30000; to = 60000; }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
