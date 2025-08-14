YADM_FOLDER=$HOME/.config/yadm
YADM_THEME_FOLDER=$YADM_FOLDER/theme
THEME_ARCHIVE=nothing.zip

plasma-apply-lookandfeeltool --apply Nothing
plasma-apply-wallpaperimage $YADM_THEME_FOLDER/wallpaper.png
plasma-apply-desktoptheme Nothing 
plasma-apply-colorscheme Nothing

kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme "Nothing"
kwriteconfig6 --file kscreenlockerrc --group Greeter --group Wallpaper --group org.k de.image --group General --key Image $YADM_THEME_FOLDER/wallpaper.png

qdbus org.kde.KWin /KWin reconfigure
kwin_x11 --replace &

