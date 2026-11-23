{ config, inputs, pkgs, ... }:
{
  imports = [ inputs.umbriel.homeModules.default inputs.noctalia.homeModules.default ];
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    bitwarden-desktop
    btop
    fastfetch
    firefox
    powertop
    ripgrep
    vesktop
    zsh
  ];
  programs.kitty = {
    enable = true;
    settings.confirm_os_window_close = 0;
  };
  programs.zsh = {
    enable = true;
    shellAliases.rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.umbriel = {
    enable = true;
    settings = {
      general = {
	xwayland = true;
	xwayland_native_resolution = true;
	show_cheatsheet = false;
	autostart = ["noctalia"];
      };
      input.focus.follows_mouse = "always";
      appearance = {
        opaque_fullscreen = true;
	blur.enabled = false;
        prefer_no_csd = true;
	corner_radius = 0;
      };
      layout.gap = 16;
      keybinds = {
        "Mod+Return" = "spawn kitty";
	"Mod" = "spawn noctalia msg panel-toggle launcher";
	"Mod+Q" = { action = "window-close"; repeat = false; };
	"Mod+Escape" = "session-quit";
      };
    };
  };
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "light";
	builtin = "Catppuccin";
      };
      wallpaper = {
        enabled = true;
        directory = "${config.xdg.userDirs.pictures}/wallpaper";
	automation.enabled = true;
      };
      shell = {
        corner_radius_scale = 0.0;
      };
      bar.default = {
        thickness = 24;
	radius = 0;
      };
    };
  };
  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    pictures = "${config.home.homeDirectory}/images";
    videos = "${config.home.homeDirectory}/videos";
    extraConfig.XDG_PROJECTS_DIR= "${config.home.homeDirectory}/projects";
  };
}
