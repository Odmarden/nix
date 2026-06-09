{ config, pkgs, ... }:

{
	home.username = "daniel";
	home.homeDirectory = "/home/daniel";
	home.stateVersion = "25.11";
	
	programs.wofi = {
  		enable = true;
  		settings = {
    			width = 400;
    			height = 300;
    			location = "center";
    			show = "drun";
    			prompt = "Search Apps...";
    			filter_rate = 100;
    			allow_markup = true;
    			no_actions = true;
    			halign = "fill";
    			orientation = "vertical";
    			content_halign = "fill";
    			insensitivy = true;
    			allow_images = true;
    			image_size = 28;
  		};
  		style = ''
    			window {
      				margin: 0px;
      				border: 2px solid #bb9af7;
      				background-color: #1a1b26;
      				border-radius: 12px;
      				font-family: "JetBrains Mono Nerd Font";
      				font-size: 14px;
    			}

    			#input {
      				margin: 5px;
      				border: none;
      				color: #c0caf5;
      				background-color: #24283b;
      				border-radius: 8px;
    			}

    			#inner-box {
      				margin: 5px;
      				border: none;
      				background-color: transparent;
    			}

    			#outer-box {
      				margin: 5px;
      				border: none;
      				background-color: transparent;
    			}

    			#scroll {
      				margin: 0px;
      				border: none;
    			}

    			#text {
      				margin: 5px;
      				border: none;
      				color: #c0caf5;
    			}

    			#entry:selected {
      				background-color: #414868;
      				border-radius: 8px;
      				outline: none;
    			}

    			#text:selected {
      				color: #7aa2f7;
    			}
  		'';
	};
	
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
    			nr = "sudo nixos-rebuild switch --flake \"/etc/nixos#nixos-btw\""; # Note: Escaping quotes with \" is best practice here
    			nru = "sudo nixos-rebuild switch --flake \"/etc/nixos#nixos-btw\" --upgrade";
			hr = "home-manager switch --flake /etc/nixos#nixos-btw";

			home = "nvim /home/daniel/git/nix/home.nix";
    			edit = "nvim /home/daniel/git/nix/configuration.nix";
    			flake = "nvim /home/daniel/git/nix/flake.nix";
    
    			# General System Commands
    			con = "cd ~/.config
			ls";
    			r = "reboot";
    			c = "clear";

    			# Hyprland/WM Edits
    			h = "hyprland";
    			hypr = "cd /home/daniel/git/clean-dotfiles/hypr";
    			hedit = "nvim /home/daniel/git/clean-dotfiles/hypr/hyprland.conf";
    			kedit = "nvim /home/daniel/git/clean-dotfiles/kitty/kitty.conf";
    
    			# Hyprpaper Wallpaper Commands
    			wp1 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper01.jpg\"";
    			wp2 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper02.jpg\"";
    			wp3 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper03.jpg\"";
    			wp4 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper04.jpg\"";
    			wp5 = "hyprctl hyprpaper wallpaper \"DP-1,~/wallpapers/wallpaper05.jpg\"";
    		        
                        # database shortcut
			update-books = "python3 /var/www/bokdatabas/books_db.py";	
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
