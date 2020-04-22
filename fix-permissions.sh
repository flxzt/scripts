#!/bin/sh
DIR="./"
chown -R felixz:felixz $DIR
find $DIR -type f -exec chmod -v 664 {} \;
find $DIR -type d -exec chmod -v 775 {} \;
find $DIR -type d -exec chmod -v +s {} \;
