#!/bin/sh
convert -size 310x310 xc:transparent \
	-fill '#9FDFBC' -stroke 'black' -strokewidth 4 \
	-draw 'roundrectangle 5,5 305,305 85,85' \
	-fill black -stroke none -font Exo2-Medium -pointsize 196 \
	-draw "text 5,222 'IHd'" \
	app/assets/images/site-icon.png
