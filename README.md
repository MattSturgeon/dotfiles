# Home Manager Config

My dotfiles configuration using [Home Manager](https://github.com/nix-community/home-manager).

## Basic usage

After making changes to the config, run `home-manager switch` to build and activate the new config.

See `man home-manager` for other options.

## Initial setup

### Requirements

- Nix (or NixOS) must be installed

### Enable flake support

To enable flakes on NixOS, add the following to your `configuration.nix` then run `nixos-rebuild --switch`:

```nix
nix = {
  package = pkgs.nixFlakes;
  extraOptions = ''
    experimental-features = nix-command flakes
  '';
};
```

To enable flakes on other systems running Nix, add the following to your `~/.config/nix/nix.cfg`:

```
experimental-features = nix-command flakes
```

### Bootstrap home manager

Clone this config to `~/.config/home-manager` and install it:

```sh
git clone https://github.com/MattSturgeon/dotfiles ~/.config/home-manager
nix run home-manager/master -- switch
```

This command effectively runs `home-manager switch` without needing `home-manager` to be installed yet. `nix run [flake] -- [args]`.

<details><summary>Alternatively, install home-manager without this config</summary>

If you'd rather have a blank/default config instead of this one, you could instead run:

```sh
nix run home-manager/master -- init --switch
cd ~/.config/home-manager
git init
```

</details>

