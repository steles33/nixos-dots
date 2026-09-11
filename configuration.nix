{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ---------------------------------------------------------
  # Boot
  # ---------------------------------------------------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ---------------------------------------------------------
  # Networking
  # ---------------------------------------------------------

  networking.networkmanager.enable = true;
  networking.hostName = "m920q";

  # ---------------------------------------------------------
  # Locale / Time
  # ---------------------------------------------------------

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

  # ---------------------------------------------------------
  # User
  # ---------------------------------------------------------

  users.users.steles33 = {
    isNormalUser = true;
    description = "steles33";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
    ];

    shell = pkgs.fish;
  };

  # ---------------------------------------------------------
  # Shell
  # ---------------------------------------------------------

  programs.fish.enable = true;

  # ---------------------------------------------------------
  # Sway / Wayland
  # ---------------------------------------------------------

  # Enable Sway as a NixOS session.
  programs.sway.enable = true;

  # Needed for some Wayland applications.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  # ---------------------------------------------------------
  # Polkit / Keyring
  # ---------------------------------------------------------

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # ---------------------------------------------------------
  # SSH
  # ---------------------------------------------------------

  services.openssh.enable = true;

  # ---------------------------------------------------------
  # Audio
  # ---------------------------------------------------------

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  services.displayManager.sddm = {
  enable = true;

  wayland = {
    enable = true;

    # default compositor is "weston", you can optionally change it to kwin
    #compositor = "kwin";
    };
  };

  # ---------------------------------------------------------
  # System packages
  # ---------------------------------------------------------

  environment.systemPackages = with pkgs; [
    # Basic tools
    vim
    wget
    git
    fastfetch
    htop
    tldr
    mc

    # Wayland utilities
    wl-clipboard
    mako
    fuzzel

    # Applications
    firefox
    vlc
    krusader

    # KDE/Qt applications
    kdePackages.konsole
    kdePackages.kate
    kdePackages.breeze-icons

    # Qt theming
    qt6Packages.qt6ct
    libsForQt5.qt5ct

    # GTK / icons
    papirus-icon-theme

    # XFCE utility
    xfce4-appfinder
    keepassxc
  ];
  # Makes icons and themes available through the standard XDG paths
  xdg.icons.enable = true;

  # ---------------------------------------------------------
  # Fonts
  # ---------------------------------------------------------

  fonts.packages = with pkgs; [
    font-awesome
    font-awesome_4
    noto-fonts
    roboto
  ];

  # ---------------------------------------------------------
  # Qt
  # ---------------------------------------------------------

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  # ---------------------------------------------------------
  # Nix
  # ---------------------------------------------------------

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  # ---------------------------------------------------------
  # System state version
  # ---------------------------------------------------------

  system.stateVersion = "26.05";
}
