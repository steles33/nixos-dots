{ pkgs, ... }:

{
  home.username = "steles33";
  home.homeDirectory = "/home/steles33";
  home.stateVersion = "26.05";

  # Packages specifically for your user
  # home.packages = with pkgs; [
  #   firefox
  #   vscode
  #   git
  # ];

  # programs.bash.shellAliases = {
  #   update = "sudo nixos-rebuild switch --flake .";
  # };
}

