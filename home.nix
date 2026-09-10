{ pkgs, ... }:

{
  home.username = "steles33";
  home.homeDirectory = "/home/steles33";
  home.stateVersion = "26.05";
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
}

