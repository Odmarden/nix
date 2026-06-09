# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Architecture Overview

This is a NixOS system configuration using Nix Flakes with Home Manager integration. The system runs Hyprland window manager on Wayland with a custom SDDM theme setup.

### Key Files Structure
- `flake.nix` - Main flake definition with inputs (nixpkgs, home-manager)
- `configuration.nix` - System-wide NixOS configuration 
- `home.nix` - User-specific Home Manager configuration for user "daniel"
- `hardware-configuration.nix` - Auto-generated hardware configuration (do not modify)

### System Architecture
- **Desktop Environment**: Hyprland (Wayland compositor)
- **Display Manager**: SDDM with custom astronaut theme
- **Package Manager**: Nix with flakes enabled
- **User Management**: Home Manager for user "daniel"
- **Shell**: Zsh with Starship prompt
- **Web Server**: Apache with mod_wsgi for Python Flask applications

## Common Development Commands

### System Rebuild and Updates
```bash
# Rebuild system configuration (alias: nr)
sudo nixos-rebuild switch --flake "/etc/nixos#nixos-btw"

# Rebuild with updates (alias: nru) 
sudo nixos-rebuild switch --flake "/etc/nixos#nixos-btw" --upgrade

# Update flake inputs
nix flake update

# Apply home-manager changes (alias: hr)
home-manager switch --flake /etc/nixos#nixos-btw
```

### Testing and Validation
```bash
# Test configuration without switching
sudo nixos-rebuild test --flake "/etc/nixos#nixos-btw"

# Check flake syntax
nix flake check

# Show system info
nixos-version
```

### Troubleshooting
```bash
# View system logs
journalctl -xe

# Check boot logs
journalctl -b

# Rollback to previous generation
sudo nixos-rebuild switch --rollback
```

## Configuration Management

### Adding Packages
- System packages: Add to `environment.systemPackages` in `configuration.nix`
- User packages: Add to `home.packages` in `home.nix`
- Python packages: Use `python3.withPackages` wrapper

### Service Configuration
- System services: Configure in `configuration.nix` under `services.*`
- User services: Configure in `home.nix` under `services.*`

### Shell Aliases
- Defined in `home.nix` under `programs.zsh.shellAliases`
- Notable aliases: `nr` (nixos-rebuild), `nru` (rebuild with upgrade), `hr` (home-manager)

### Hyprland Configuration
- User maintains separate Hyprland config at `/home/daniel/git/clean-dotfiles/hypr/`
- Wallpaper management through hyprpaper with aliases `wp1-wp5`

## Important Notes

### Git Repository Safety
- The repository requires git safe directory configuration due to ownership
- Run: `git config --global --add safe.directory /etc/nixos`

### Web Development Setup
- Apache configured with mod_wsgi for Python Flask applications
- Document root: `/var/www/bokdatabas`
- SSL enabled with certificates in `/var/lib/httpd/`
- Ports 80 and 443 open in firewall

### Display Configuration
- Custom SDDM theme with wallpaper support
- Wayland session with XWayland fallback
- Environment variables set for proper Wayland app behavior

### Backup and Recovery
- Hardware configuration backed up in `backup/` directory
- System supports generation rollbacks via `nixos-rebuild switch --rollback`
- Home Manager configurations have separate backup mechanism
