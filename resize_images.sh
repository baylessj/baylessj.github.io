#! /bin/bash 
find ./ -maxdepth 1 -type f -exec convert {} -resize 640x600 {} \;

