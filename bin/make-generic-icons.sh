#!/bin/sh

TEMPDIR=/tmp

###
#   5* Dark and Light
###

function add_faction_to
{
	SOURCE=$1  # 137x137
	FACTION=$2
	DEST=$3
	C_SOURCE="app/assets/images/generics/4-$FACTION.png"

	convert $C_SOURCE \
		\( +clone -threshold -1 -negate -fill white \
		   -draw "circle 25,24 25,7" \
		\) -alpha off -compose copy_opacity -composite \
		$TEMPDIR/aft-$f-$$.png
	composite $TEMPDIR/aft-$f-$$.png $SOURCE $DEST
	rm $TEMPDIR/aft-$f-$$.png
}

for f in Dark Light; do
	add_faction_to app/assets/images/generics/5-Any.png $f app/assets/images/generics/5-$f.png
done

###
#   6* all factions
###

function make_six_star_template
{
	SOURCE=$1  # 137x137
	DEST=$2
	STAR="app/assets/images/generics/pink-star.png"
	PUZZLE="app/assets/images/generics/puzzle-piece.png"
	convert $SOURCE -crop 117x117+10+10 +repage $TEMPDIR/mss1-$$.png
	convert $TEMPDIR/mss1-$$.png \
		\( +clone -alpha extract \
		   -draw 'fill black polygon 0,0 0,14 14,0 fill white circle 14,14 14,0' \
		   \( +clone -flip \) -compose Multiply -composite \
		   \( +clone -flop \) -compose Multiply -composite \
		\) -alpha off -compose CopyOpacity -composite \
		$TEMPDIR/mss2-$$.png
	convert $TEMPDIR/mss2-$$.png \
		-modulate 100,100,33.3 \
		$TEMPDIR/mss3-$$.png
	convert $TEMPDIR/mss3-$$.png -fill black \
		-draw "rectangle 21,97 98,117" \
		$TEMPDIR/mss4-$$.png
	composite -geometry +51+97 \
		$STAR $TEMPDIR/mss4-$$.png \
		$TEMPDIR/mss5-$$.png
	composite -geometry +10+10 \
		$TEMPDIR/mss5-$$.png $SOURCE \
		$TEMPDIR/mss6-$$.png
	convert $TEMPDIR/mss6-$$.png -fill '#F4D2AF' \
		-draw "rectangle 31,127 108,130" \
		$TEMPDIR/mss7-$$.png
	composite $PUZZLE $TEMPDIR/mss7-$$.png $DEST
	rm $TEMPDIR/mss?-$$.png
}

make_six_star_template app/assets/images/generics/4-Any.png app/assets/images/generics/6-Any.png
for f in Shadow Fortress Abyss Forest Dark Light; do
	add_faction_to app/assets/images/generics/6-Any.png $f app/assets/images/generics/6-$f.png
done
