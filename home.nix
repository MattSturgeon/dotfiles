{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "matt";
  home.homeDirectory = "/home/matt";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can even make a symlink directly to a file without adding anything to
    # # the Nix store.
    # ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./nvim_config

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # Git
    git = {
      enable = true;
      userName = "Matt Sturgeon";
      userEmail = "matt@sturgeon.me.uk";
      signing = {
        key = "ED1A8299";
        signByDefault = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
      delta.enable = true;
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    # Neovim
    nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      colorschemes.catppuccin = {
        enable = true;
        background.light = "macchiato";
        background.dark = "mocha";
      };
      globals = {
        mapleader = " ";
      };
      options = {
        number = true; # Line numbers
	relativenumber = true; # ^Relative
	shiftwidth = 4; # Tab width
	cursorline = true; # Highlight the current line
	scrolloff = 8; # Ensure there's at least 8 lines around the cursor
	title = true; # Let vim set the window title
      };
      maps = {
        # Better up/down movement
        normalVisualOp."j" = {
	  action = "v:count == 0 ? 'gj' : 'j'";
	  expr = true;
	  silent = true;
	};
        normalVisualOp."k" = {
          action = "v:count == 0 ? 'gk' : 'k'";
	  expr = true;
	  silent = true;
	};

        # Better window motions
        normal."<C-h>" = {
	  action = "<C-w>h";
	  desc = "Go to left window";
        };
        normal."<C-j>" = {
          action = "<C-w>j";
	  desc = "Go to lower window";
        };
        normal."<C-k>" = {
          action = "<C-w>k";
	  desc = "Go to upper window";
        };
        normal."<C-l>" = {
          action = "<C-w>l";
	  desc = "Go to right window";
        };
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    extraConfig = ''
      bind=SUPER,E,exit,
    '';
  };
}
