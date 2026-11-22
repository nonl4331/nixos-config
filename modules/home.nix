{ config, inputs, pkgs, ... }:
{
  imports = [ inputs.umbriel.homeModules.default inputs.noctalia.homeModules.default ];
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    btop
    firefox
    kitty
    ripgrep
    zsh
  ];
  programs.zsh = {
    enable = true;
    shellAliases.rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.umbriel.enable = true;
  programs.noctalia = {
    enable = true;
    settings.theme = "light";
  };
}
