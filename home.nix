{ config, pkgs, ... }:

{
	home.username = "daniel";
	home.homeDirectory = "/home/daniel";
	home.stateVersion = "25.11";

	programs.git = {
		enable = true;

   		settings = { # This new block replaces both the old 'extraConfig' and holds the user settings
    			user = {
      				name = "Odmarden";          # The new path: settings.user.name
      				email = "untraxx@duck.com"; # The new path: settings.user.email
    			};

      			credential.helper = "libsecret"; 
 
  		};
	};

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo i use nixos, btw";
		};
	};

	programs.zsh = {
  		enable = true;
  		initContent = ''
			# 1. Initialize Starship prompt
    			eval "$(starship init zsh)"

    			# 2. Source the system profile (Crucial Fix for finding binaries like git-credential-libsecret)
    			. /etc/profile
    
    			# 3. Handle history settings (from your old .zshrc)
    			HISTFILE=~/.histfile
    			HISTSIZE=1000
    			SAVEHIST=1000
    			setopt extendedglob
    
    			# 4. Handle auto-loading (from your old .zshrc)
    			autoload -Uz compinit
    			compinit
  		'';

		# --- ALIASES ---
  # This block converts all your 'alias' lines into declarative attributes
  		shellAliases = {
    			# NixOS Rebuild/Config Edits
    			nr = "sudo nixos-rebuild switch --flake \"~/git/nix#nixos-btw\""; # Note: Escaping quotes with \" is best practice here
    			nru = "sudo nixos-rebuild switch --flake \"~/git/nix#nixos-btw\" --upgrade";
			home = "sudo nvim ~/git/nix/home.nix";
    			edit = "sudo nvim ~/git/nixos/configuration.nix";
    			flake = "sudo nvim ~/git/nixos/flake.nix";
    
    			# General System Commands
    			con = "cd ~/.config";
    			r = "reboot";
    			c = "clear";
    
    			# Hyprland/WM Edits
    			h = "hyprland";
    			hypr = "cd ~/.config/hypr";
    			hedit = "sudo nvim ~/.config/hypr/hyprland.conf";
    			kedit = "sudo nvim ~/.config/kitty/kitty.conf";
    
    			# Hyprpaper Wallpaper Commands
    			wp1 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper01.jpg\"";
    			wp2 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper02.jpg\"";
    			wp3 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper03.jpg\"";
    			wp4 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper04.jpg\"";
    			wp5 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper05.jpg\"";
    		
		};
	

 		zplug = {
            		enable = true;
            		plugins = [
                		{ name = "zsh-users/zsh-autosuggestions"; }
            		];
  		};
	};



	home.packages = with pkgs; [
  
  		libsecret
	];
}
