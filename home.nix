{ config, pkgs, ... }:

{
	home.username = "daniel";
	home.homeDirectory = "/home/daniel";
	home.stateVersion = "25.11";
	programs.git.enable = true;
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo i use nixos, btw";
		};

	};

#	programs.zsh = {
#		enable = true;
#		enableCompletions = true;
#		autosuggestion.enable = true;
#		syntaxHighlighting.enable = true;
#
#		shellAliases = {
#			ll = "ls -l";
#			update = "sudo nixos-rebuild switch";
#		};
#		
#		oh-my-zsh = {
#			enable = true;
#			plugins = [ "git" "thefuck" ];
#			theme = "robbyrussell";
#		};
#	};

}
