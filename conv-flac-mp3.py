#!/usr/bin/env python3

from glob import glob
from subprocess import run

for flac in glob("**/*.flac", recursive=True): 
    mp3 = flac.replace(".flac", ".mp3") 
    run(["ffmpeg", "-i", flac, "-c:v", "copy", "-b:a", "320k", mp3])

