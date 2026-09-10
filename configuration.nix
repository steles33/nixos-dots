
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.networkmanager.enable = true;
  networking.hostName = "m920q";
  time.timeZone = "Europe/Berlin";
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
  console.keyMap = "de-latin1-nodeadkeys";
  users.users."steles33" = {
    isNormalUser = true;
    description = "steles33";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    packages = with pkgs; [];
  };
  nixpkgs.config.allowUnfree = true;
  programs.fish.enable = true;
  users.users.steles33.shell = pkgs.fish;
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
     fuzzel
     kdePackages.konsole
     kdePackages.kate
     kdePackages.breeze-icons
     qt6Packages.qt6ct
     libsForQt5.qt5ct
     vlc
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
  fonts.packages = with pkgs; [
    font-awesome_4
    font-awesome
    noto-fonts
    roboto
  ];
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  environment.sessionVariables = { QT_QPA_PLATFORMTHEME = "qt5ct"; };
  system.stateVersion = "26.05";

}
