
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "m920q";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."steles33" = {
    isNormalUser = true;
    description = "steles33";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  users.users.steles33.shell = pkgs.fish;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
     vim
     wget
     git
     fastfetch
     htop
     tldr
     mc
     wl-clipboard
     mako
     kdePackages.konsole
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      foot
      dmenu
      grim
      slurp
      flameshot
  ];
  };

  programs.waybar.enable = true;
  programs.firefox.enable = true;

  #Fonts
  fonts.packages = with pkgs; [
    font-awesome_4
    font-awesome
    noto-fonts
    roboto
  ];

  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.xserver.enable = true;
  security.polkit.enable = true;

  system.stateVersion = "26.05";

}
