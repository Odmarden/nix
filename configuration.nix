{ config, lib, pkgs, ... }:

# { nixpkgs.config.allowUnfree = true; }

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  
  programs.nix-ld.enable = true;

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

nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Ett bra komplement som optimerar lagringen genom att ta bort dubbletter
  nix.settings.auto-optimise-store = true;

  networking = {
  	hostName = "nixos"; 
	useDHCP = false;
	interfaces.enp0s31f6.ipv4.addresses = [ {
		address = "192.168.1.50";
		prefixLength = 24;
	} ];

	defaultGateway = "192.168.1.1";
	nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };


  # 1. Installera Apache och aktivera tjänsten
  #services.httpd.enable = true;
  
  # 2. Se till att WSGI-modulen för Python finns med
 # services.httpd.extraModules = [ "wsgi" ];

# 3. Öppna port 80 i brandväggen så att du når den från din Mac
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # 4. Definiera din webbplats (VirtualHost)
 # services.httpd = {
#	enable = true;
#	user = "daniel";
#	group = "users";
#	adminAddr = "admin@localhost";
#	enableLogrotation = false;
#	enablePHP = false;
#	extraConfig = ''
#		DefaultRuntimeDir /run/httpd
#	'';

#	extraModules = [ "wsgi" ];
  	
 services.httpd = {
    enable = true;
    adminAddr = "admin@localhost";
    extraConfig = ''
    WSGIPythonPath ${pkgs.python3.withPackages (ps: with ps; [ flask ])}/${pkgs.python3.sitePackages}
  '';
    extraModules = [
      { name = "wsgi"; path = "${pkgs.apacheHttpdPackages.mod_wsgi3}/modules/mod_wsgi.so"; }
    ];


    virtualHosts."localhost" = {
#     default = true;
      addSSL = true;
      sslServerCert = "/var/lib/httpd/server.crt";
      sslServerKey = "/var/lib/httpd/server.key";

      documentRoot = "/var/www/bokdatabas";
        extraConfig = ''
          WSGIScriptAlias / /var/www/bokdatabas/wsgi.py
          <Directory /var/www/bokdatabas>
            Require all granted
          </Directory>
        '';
     };
};
 # <--- Se till att denna stänger services.httpd

  services.openssh = {
  	enable = true;
	settings = {
		PasswordAuthentication = true;
		PermitRootLogin = "yes";
	};
  };

#  services.getty.autologinUser = "daniel";
 
#  services.displayManager.sddm.enable = true;
#  services.displayManager.sddm.wayland.enable = true;
#  services.displayManager.defaultSession = "hyprland";
#  services.greetd.enable = true;
 	
 
#  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  
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
  	shell = pkgs.zsh;

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
	fastfetch
	yazi
	solaar
	links2
	ungoogled-chromium
	localsend
	joplin-desktop
	hyprlock
	hypridle
	btop
	vivaldi
	openssh
	python3
	rsync
	openssl
	(python3.withPackages (ps: with ps; [
		flask
	]))

  ];

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  system.stateVersion = "25.11"; 

}

