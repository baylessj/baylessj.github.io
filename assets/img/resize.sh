#! /bin/bash

for SIZE in 360 480 640
do
    convert $1 -resize ${SIZE}x${SIZE} ./${SIZE}/$1
done
