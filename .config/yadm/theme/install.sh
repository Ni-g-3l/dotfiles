sudo apt install gtk2-engines-murrine flatpak -y

sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons
sudo flatpak override --filesystem=xdg-config/gtk-4.0
