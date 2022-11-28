#!/usr/bin/env python
import os
import random

test = False
wall = ""


def wallpaperFind():
    global test
    global wall

    while test == False:
        for file in os.listdir("/home/caue/Pictures/wallpapers/"):
            a = random.randrange(1, 590)
            b = random.randrange(1, 590)
            if a == b:
                test = True
                wall = file
                break
    return 1


def wallpaperSet():
    os.system(f"echo {wall} > $HOME/.config/wallpaper.txt")
    os.system("killall swaybg")
    os.system(f"swaybg -i $HOME/Pictures/wallpapers/{wall} -m fill")
    return 1


wallpaperFind()
wallpaperSet()
