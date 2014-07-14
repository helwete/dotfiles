#! /usr/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Load fonts
xset +fp /usr/share/fonts/local
xset fp rehash

# Set keyboard layout
setxkbmap -layout se

# Merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge .Xresources

# Normal cursor
xsetroot -cursor_name left_ptr &

# Set wallpaper
hsetroot -full ~/Pictures/ev0uDRg.jpg &

mpd &
mpdscribble &

# Mount external hard drive
sudo mount /dev/sdc1 /mnt/exthdd &

# Specify output
xrandr --output LVDS --primary

conky -c ~/2bwm/panel_conky | dzen2 -p -ta r -fn "-*-tamsynmod-medium-r-normal-*-14-101-100-100-c-70-iso8859-1" -h 18 &
sleep 0.5
~/2bwm/panel | dzen2 -p -ta l -fn "-*-tamsynmod-medium-r-normal-*-14-101-100-100-c-70-iso8859-1" -h 18 -w 1100 &
 
urxvt &
sudo /usr/bin/pac_sync.sh &
exec $1
