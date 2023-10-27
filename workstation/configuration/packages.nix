{ config, pkgs, ... }:

{

  services.flatpak = {
	  enable = true;
	  remotes.flathub = "https://flathub.org/repo/flathub.flatpakrepo";
	  packages = [
		"flathub:app/com.github.wwmm.pulseeffects//stable:6a334a6e4155e37da928dbb1f5b971800f804ba9bc4cb34f5c650bbeeff93345"
		"flathub:app/com.obsproject.Studio//stable"
		"flathub:app/org.kde.kdenlive//stable"
		"flathub:app/io.lmms.LMMS//stable"
		"flathub:app/org.audacityteam.Audacity//stable"
		"flathub:app/org.gimp.GIMP//stable"
		"flathub:app/org.blender.Blender//stable"
		"flathub:app/org.mozilla.firefox//stable"
		"flathub:app/com.github.Eloston.UngoogledChromium//stable"
	  	"flathub:app/com.github.micahflee.torbrowser-launcher//stable"
		"flathub:app/org.videolan.VLC//stable"
		"flathub:app/com.valvesoftware.Steam//stable"
		"flathub:app/com.valvesoftware.SteamLink//stable"
		"flathub:app/org.keepassxc.KeePassXC//stable:e819ca2682dde064b1969a0c338fdb467a584e22cfec7472c7ec44a4c72d61c8"
		"flathub:app/org.libreoffice.LibreOffice//stable"
		"flathub:app/org.wireshark.Wireshark//stable"
		"flathub:app/org.filezillaproject.Filezilla//stable"
		"flathub:app/com.visualstudio.code//stable"
		"flathub:app/io.qt.QtCreator//stable"
		"flathub:app/org.deluge_torrent.deluge//stable"
	  ];
  };

  environment.systemPackages = with pkgs; [ 
     python3
     spice-vdagent
     neovim
     gnupg
     killall
     #sops
     wget
     curl
     git
     virt-manager
     flatpak
     podman
     podman-compose
     x11docker
     pinentry-gnome
     gnome.adwaita-icon-theme
     gnomeExtensions.appindicator
     gparted
     lvm2
     iotop
     lm_sensors
     jq
     yq
     bluez
     mysql-workbench
  ];

  environment.gnome.excludePackages = (with pkgs; [
     gnome-photos
     gnome-tour
  ]) ++ (with pkgs.gnome; [
     cheese
     gnome-music
     gnome-terminal
     gedit
     epiphany
     geary
     evince
     gnome-characters
     totem
     tali
     iagno
     hitori
     atomix 
  ]);

}
