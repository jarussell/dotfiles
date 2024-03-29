#!/bin/bash

# create variables
while read L; do
	k="`echo "$L" | cut -d '=' -f 1`"
	v="`echo "$L" | cut -d '=' -f 2`"
        #echo "$L" >> ~/.config/pianobar/test.txt
	export "$k=$v"
done < <(grep -e '^\(title\|artist\|album\|stationName\|songStationName\|pRet\|pRetStr\|wRet\|wRetStr\|songDuration\|songPlayed\|rating\|coverArt\|stationCount\|station[0-9]*\|audioUrl\)=' /dev/stdin) # don't overwrite $1...

logger -t "pianobar" "eventcmd.sh: $@"

case "$1" in
	songstart)
                #output filename, artist, title, and album title to a file for downloading
                echo -e "$title - $artist.m4a\n$title\n$artist\n$album" >$HOME/.config/pianobar/name.txt
		# Download cover art
		wget $coverArt -O /tmp/pandora >/dev/null 2>&1 && convert /tmp/pandora /tmp/pandora.png
		# Use the cover art to when displaying a GUI notification
		[ -n "$DISPLAY" ] && \
			notify-send -i /tmp/pandora.png "Pandora Radio" "Now playing: $title by $artist"
		# System logger. Cause why not? (And a little debugging)
		logger -t "pianobar" "song playing: $title by $artist"
		# Delete the cover art
		rm /tmp/pandora /tmp/pandora.png &>/dev/null
		# Update the terminal's title (this is only set when the information is
		# displayed, which is *not* redrawn after unlocking the pause mutex, so
		# we need to update the titlebar to reflect the 'Now Playing' status
		# instead of paused as set by the songpause action)
		echo -ne "\e]2;pianobar ♫ ${title} by ${artist}\x07"

                #update tmux title
                if [[ $USER == root || `ps -ef | grep tmux | grep -v grep | wc -l` -gt 0 ]]; then
                    #tmux rename-session "♫ $title"
		    echo -ne "\033k♫ ${title}\033\\"
                fi

		;;

	*)  # Generic handler, for when things break.
		if [ "$pRet" -ne 1 ]; then
			# pRet == error code from libpiano
			notify-send "Pandora Radio" "$1 failed: $pRetStr"
		elif [ "$wRet" -ne 1 ]; then
			# wRet == error code from libwaitress
			notify-send "Pandora Radio" "$1 failed: Network error: $wRetStr"
		fi
		;;
esac

