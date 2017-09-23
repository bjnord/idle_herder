#!/bin/sh

SOURCE=app/assets/images/generics/5-Any.png

C_SOURCE=app/assets/images/generics/4-Dark.png
CIRCLE=app/assets/images/generics/5-Dark-c.png
DEST=app/assets/images/generics/5-Dark.png

convert $C_SOURCE \( +clone -threshold -1 -negate -fill white -draw "circle 25,24 25,7" \) -alpha off -compose copy_opacity -composite $CIRCLE
composite $CIRCLE $SOURCE $DEST
rm $CIRCLE

C_SOURCE=app/assets/images/generics/4-Light.png
CIRCLE=app/assets/images/generics/5-Light-c.png
DEST=app/assets/images/generics/5-Light.png

convert $C_SOURCE \( +clone -threshold -1 -negate -fill white -draw "circle 25,24 25,7" \) -alpha off -compose copy_opacity -composite $CIRCLE
composite $CIRCLE $SOURCE $DEST
rm $CIRCLE
