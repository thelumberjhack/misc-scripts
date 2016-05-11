#!/usr/bin/zsh
# Setup laptop screens. When 2 screens other than eDP1 are connected,
# disable main screen display and use the other ones.
HDMI1=`xrandr -q | grep HDMI1 | awk {'print $2'}`
VGA1=`xrandr -q | grep VGA1 | awk {'print $2'}`
CONNECTED="connected"

if [[ "$HDMI1" -eq "$CONNECTED" ]]; then
    if [[ "$VGA1" -eq "$CONNECTED" ]]; then
        xrandr --output eDP1 --off\
        --output HDMI1 --auto --primary\
        --output VGA1 --right-of HDMI1 --auto
    else
        xrandr --output eDP1 --primary --auto\
        --output HDMI1 --right-of eDP1 --auto
    fi
elif [[ "$VGA1" -eq "$CONNECTED" ]]; then
    xrandr --output eDP1 --primary --auto\
    --output VGA1 --right-of eDP1 --auto
else
    echo "No other screens detected."
fi

