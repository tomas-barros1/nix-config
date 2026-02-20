{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  #Home manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.tom = import ./home.nix;

  # Bootloader
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "nixos";

  # Network
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/Bahia";

  # Locale
  i18n.defaultLocale = "pt_BR.UTF-8";
  console.keyMap = "us";

  # Desktop (KDE Plasma 6)
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "intl";
  };

  # User
  users.users.tom = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  # Programs
  programs.firefox.enable = true;

  programs.fish.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    alacritty-theme
  ];

  # Fontes
  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-mono
  ];

  # SSH
  services.openssh = {
    enable = true;
  };

  # NixOS version (NÃO MUDE depois de instalar)
  system.stateVersion = "25.11";
}
