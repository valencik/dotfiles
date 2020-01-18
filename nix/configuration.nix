# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sdb";

  # networking.hostName = "nixos"; # Define your hostname.

  # Enable docker as a service
  virtualisation.docker.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Toronto";

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
     gcc
     shellcheck
     sbt
     ripgrep
     tor
     wget
     zip
     unzip
     jq
     htop
     exa
     ntfs3g
     docker
     firefox
     ffmpeg-full
     mpv
     youtube-dl
     blender
     lutris
     steam
     mesa
     mesa_drivers
     vulkan-tools
     haskellPackages.xmobar
     linuxPackages.digimend
     xf86_input_wacom
     vscode-with-extensions
     mupdf
     darktable
     discord
   ];

  # Huion table
  #services.xserver.digimend.enable = true;

  # List services that you want to enable:
  nixpkgs.config.allowUnfree = true;
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  services.deluge = {
    enable = true;
    web.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Setup GPU drivers
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Compton is a visual compositor that should reduce screen tearing
  services.compton = {
    enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    desktopManager = {
      gnome3.enable = true;
    };

    displayManager = {
      defaultSession = "gnome";
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andrew = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # Mount disks
  fileSystems."/bigdata" = {
    device = "/dev/disk/by-label/bigtib";
    fsType = "ext4";
  };
  fileSystems."/data" = {
    device = "/dev/disk/by-label/tib";
    fsType = "ext4";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
