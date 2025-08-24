YADM_FOLDER=$HOME/.config/yadm
YADM_THEME_FOLDER=$YADM_FOLDER/theme
THEME_ARCHIVE=nothing.zip

cd /tmp

sudo apt install gtk2-engines-murrine flatpak -y

sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons
sudo flatpak override --filesystem=xdg-config/gtk-4.0


git clone git@github.com:Fausto-Korpsvart/Gruvbox-GTK-Theme.git
cd /tmp/Gruvbox-GTK-Theme/themes
./install.sh -t "orange"

gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Orange-Dark"
