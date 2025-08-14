YADM_FOLDER=$HOME/.config/yadm
YADM_THEME_FOLDER=$YADM_FOLDER/theme
THEME_ARCHIVE=nothing.zip

plasma-apply-lookandfeeltool --apply Nothing
plasma-apply-wallpaperimage $YADM_THEME_FOLDER/wallpaper.png
plasma-apply-desktoptheme Nothing 
plasma-apply-colorscheme Nothing
kwriteconfig5 --file kwinrc --group org.kde.kdecoration2 --key theme "Nothing"

qdbus org.kde.KWin /KWin reconfigure
kwin_x11 --replace &

# mkdir -p $HOME/.local/share/plasma/desktoptheme

# curl -Lo $THEME_ARCHIVE https://gitlab.com/jomada/nothing/-/archive/main/nothing-main.zip

# unzip $THEME_ARCHIVE

# cp nothing-main/Nothing $HOME/.local/share/plasma/desktoptheme -r
# cp nothing-main/color-schemes/* $HOME/.local/share/color-schemes
# cp nothing-main/wallpapers/* $HOME/.local/share/wallpapers -r

# mkdir $HOME/.local/share/aurorae/themes -p
# cp nothing-main/aurorae/Nothing $HOME/.local/share/aurorae/themes -r


# rm $THEME_ARCHIVE nothing-main -rf
