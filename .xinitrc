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

# Start gpg-agent
eval $(gpg-agent --daemon)

# Mount external hard drive
sudo mount /dev/sdc1 /mnt/exthdd &

# Specify output
xrandr --output LVDS --primary

# dzen2 settings
screenwidth=`xrandr --current | grep current | awk '{print $8}'`
panel1width=`printf "%.0f" $(echo "scale=5; (45.572916*$screenwidth)/100" | bc)`
panel2width=`printf "%.0f" $(echo "scale=5; (10.41600*$screenwidth)/100" | bc)`
panel3width=`printf "%.0f" $(echo "scale=5; (40.10416*$screenwidth)/100" | bc)`
panel4width=`printf "%.0f" $(echo "scale=5; (3.90625*$screenwidth)/100" | bc)`
panel2slavewidth=`printf "%.0f" $(echo "scale=5; (8.33333*$screenwidth)/100" | bc)`
panel2xoffset=$panel1width
panel3xoffset=$(($panel2xoffset + $panel2width))
panel4xoffset=$(($panel3xoffset + $panel3width))
panelheight=18
font="-*-tamsynmod-medium-r-normal-*-14-101-100-100-c-70-iso8859-1"

# Start the 3 dzen panels to create the statusbar
$HOME/2bwm/panel | dzen2 -p -ta l -fn "$font" -h $panelheight -tw $panel1width &
$HOME/2bwm/calendar | dzen2 -p -u -fn "$font" -x $panel2xoffset -tw $panel2width -h $panelheight -w $panel2slavewidth -sa c -l 8 -e 'button1=togglecollapse' &
conky -c $HOME/2bwm/panel_conky | dzen2 -p -ta r -fn "$font" -x $panel3xoffset -h $panelheight -tw $panel3width &
$HOME/2bwm/volume | dzen2 -p -fn "$font" -x $panel4xoffset -h $panelheight -tw $panel4width -e 'button5=exec:amixer set Master 5%-:;button4=exec:amixer set Master 5%+:;button1=exec:amixer set Master toggle:' &

#sxhkd &
urxvt &
sudo /usr/bin/pac_sync.sh &
exec $1
