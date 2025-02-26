# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include media setup
      ./media.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  # try and increase file limut for systemd
  # trying to prevent "too many open files" in deluged
  systemd.user.extraConfig = "DefaultLimitNOFILE=32000";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE desktop env
  services.xserver.desktopManager.xfce.enable = true;
  services.displayManager.defaultSession = "xfce";

  # # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable nix features
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

  # Hopefully to enable Tuple via flatpak
  # https://matthewrhone.dev/nixos-package-guide#enabling-flatpak
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     zsh
     vim
     xclip  # system clipboard support for vim
     git
     tmux
     fzf
     binutils
     coreutils
     usbutils
     man-pages
     file
     ripgrep
     wget
     zip
     unzip
     jq
     htop
     eza
     rlwrap # rlwrap adds readline functionality to tools without it like idris repl
     nix-prefetch-github # get sha256, e.g. 'nix-prefetch-github --rev v0.2.0 idris-lang Idris2'
     clinfo # for confirming OpenCL driver install
     # rocm-opencl-icd # Enable OpenCL for AMD GPUs in Blender
     firefox
     lmms
     ardour
   ];

  # Huion New 1060 Plus
  # Supported via digimend-kernel-drivers
  services.xserver.wacom.enable = true;  # default true


  # nix-direnv
  programs.direnv = {
    enable = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    UseDns = true;
    GSSAPIAuthentication = false;
  };

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable docker as a service
  virtualisation.docker.enable = true;

  # Enable virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["andrew"];

  # setup gnupg
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    4000
    4242
    6881
    9999
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andrew = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "input" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  users.users.tester = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "input" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # enable nix directories in zsh PATH
  programs.zsh.enable = true;

  # Mount disks
  fileSystems."/bigdata" = {
    device = "/dev/disk/by-label/bigtib";
    fsType = "ext4";
  };
  fileSystems."/data" = {
    device = "/dev/disk/by-label/tib";
    fsType = "ext4";
  };
  fileSystems."/mediadata" = {
    device = "/dev/disk/by-label/media";
    fsType = "ext4";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

