{ config, pkgs, ... }:

{
    home.homeDirectory = "/home/tom";
    home.stateVersion = "24.11";

    programs.fish = {
        enable = true;
        shellAliases = {
          nr = "sudo nixos-rebuild switch";
        };
    };

    home.packages = with pkgs; [
        bat
        alacritty
    ];

    programs.alacritty = {
        enable = true;
        theme = "catppuccin_mocha";
        settings = {
            window = {
                opacity = 0.9;
                padding.x = 14;
                padding.y = 14;
                decorations = "None";
            };
            env.term = "xterm-256color";
            font.normal = {
                family = "CaskaydiaMono Nerd Font";
                style = "Regular";
            };
            font.size = 12;
        };
    };

}
