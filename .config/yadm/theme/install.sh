YADM_FOLDER=$HOME/.config/yadm
YADM_THEME_FOLDER=$YADM_FOLDER/theme
THEME_ARCHIVE=nothing.zip

cd /tmp

git clone git@github.com:vinceliuice/Graphite-gtk-theme.git
cd Graphite-gtk-theme
./install.sh

dconf write /org/gnome/shell/extensions/user-theme/name "'Graphite-orange-Dark'"

