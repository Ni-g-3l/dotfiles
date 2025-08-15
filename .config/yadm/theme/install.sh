YADM_FOLDER=$HOME/.config/yadm
YADM_THEME_FOLDER=$YADM_FOLDER/theme
THEME_ARCHIVE=nothing.zip

cd /tmp

git clone git@github.com:vinceliuice/Graphite-gtk-theme.git
cd Graphite-gtk-theme
./install.sh

cd /tmp
git clone git@github.com:vinceliuice/Graphite-kde-theme.git
cd Graphite-kde-theme
./install.sh

plasma-apply-lookandfeeltool --apply Graphite-dark
plasma-apply-wallpaperimage $YADM_THEME_FOLDER/wallpaper.png
plasma-apply-desktoptheme Graphite-dark
plasma-apply-colorscheme Graphitedark

dbus-send --session --dest=org.kde.GtkConfig --type=method_call /GtkConfig org.kde.GtkConfig.setGtkTheme 'string:Graphite-orange-Dark'
kwriteconfig5 --file kwinrc --group org.kde.kdecoration2 --key theme "Graphite-dark-round"

qdbus org.kde.KWin /KWin reconfigure 
konsole -e kquitapp5 plasmashell && kstart5 plasmashell --windowclass plasmashell --window Desktop
