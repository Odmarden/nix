{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 # boot.kernelParams = [ "i915.modeset=1" ];
 # boot.initrd.kernelModules = [ "i915" ];

 # hardware.graphics.enable = true;  
 # hardware.graphics.extraPackages = with pkgs; [
#	intel-media-driver
#	intel-vaapi-driver
#	libvdpau-va-gl
 # ];

  networking.hostName = "nixos"; 

#  services.getty.autologinUser = "daniel";
 
#  services.displayManager.sddm.enable = true;
#  services.displayManager.sddm.wayland.enable = true;
#  services.displayManager.defaultSession = "hyprland";
#  services.greetd.enable = true;
 	
 
  networking.networkmanager.enable = true;

  
  time.timeZone = "Europe/Amsterdam";

  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	package = pkgs.hyprland;
	
  };

  
  users.users.daniel = {
  	isNormalUser = true;
     	extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     	packages = with pkgs; [
		tree
	];
  };

  programs.firefox.enable = true;

  
  environment.systemPackages = with pkgs; [
	vim 
	wget
	foot
	waybar
	kitty
	wofi
	swaybg
	neovim
	nano
	hyprpaper
	starship
	quickshell
	wl-clipboard
	neofetch
	yazi
	solaar
	links2
	ungoogled-chromium
  ];

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  system.stateVersion = "25.11"; 

}

