#!/usr/bin/env python

import os
import random
import subprocess as s
from math import floor
from requests import get

WALLPAPER_CHOICE_ROFI_MENU = (
    "1. Wallpaper From Dir\n2. Wallpaper From Wallhaven\n3. Exit"
)
HOME_PATH = os.environ.get("HOME")
QUERY_CACHE_PATH = f"{HOME_PATH}/.cache/query.txt"
WALLPAPER_DIR_PATH = f"{HOME_PATH}/Pictures/wallpapers"


def notifyWallpaper(title: str, body):
    b = "\n".join(body)
    s.run(f'fish -c \'notify-send "{title}" "{b}" \'', shell=True)


def getWallpaperFromWallhaven(query: str = ""):
    url = "https://wallhaven.cc/api/v1/search?"
    wallpaperDir = os.path.expanduser("~/.local/share/backgrounds/")
    params = {
        "sorting": "random",
        "atleast": "1360x768",
        "ratios": "16x9",
        "categories": "110",
        "q": f"-game -games {query}",
    }
    r = get(url=url, params=params)
    response = r.json()
    print(response)
    randomNumberWallpaper = floor(random.random() * len(response["data"]))
    print(randomNumberWallpaper)
    wallpaper = response["data"][randomNumberWallpaper]["path"]
    print(f"Query: { query }")
    print(f'Colors: {response["data"][randomNumberWallpaper]["colors"] }')
    print(f'Catery: {response["data"][randomNumberWallpaper]["category"]}')
    notifyWallpaper(
        "Wallpaper From Wallhaven",
        [
            f"Query: {query}",
            f'Colors: {response["data"][randomNumberWallpaper]["colors"]}',
            f'Catery: {response["data"][randomNumberWallpaper]["category"]}',
        ],
    )
    deletePreviousWallpapers(wallpaperDir)
    with open(f"{wallpaperDir}{os.path.basename(wallpaper)}", "wb") as wallpaperFile:
        wallpaperFile.write(get(wallpaper).content)
        setWallpaper(wallpaperFile.name)


def getWallhavenOption():
    WALLPAPER_WALLHAVEN_ASK = (
        "1. Random\n2. Query\n3. Last Query\n4. Move Wallpaper\n5. Exit"
    )
    opt = (
        s.check_output(
            f'echo "{WALLPAPER_WALLHAVEN_ASK}" | rofi -dmenu -i -p "Choose" ',
            shell=True,
            text=True,
        )
        .strip("b'")
        .split(".")[0]
    )
    return opt


def deletePreviousWallpapers(wallpaperDir):
    prevWallpapers = os.listdir(wallpaperDir)
    for prevWallpaper in prevWallpapers:
        wallpaper_path = os.path.join(wallpaperDir, prevWallpaper)
        if os.path.isfile(wallpaper_path):
            os.remove(wallpaper_path)


def getPrevQuerys(queryFilePath: str):
    prevQuery = ""
    if os.path.exists(queryFilePath):
        file = open(queryFilePath, "r")
        prevQuery = file.read().strip()
    return prevQuery


def getQueryHistory():
    lines = []
    prevQuerys = getPrevQuerys(QUERY_CACHE_PATH)

    query = s.check_output(
        f'echo "{prevQuerys}" | rofi -dmenu -i -p "Query" -theme-str "listview {{lines: 5;}}"',
        shell=True,
        text=True,
    ).strip()

    if os.path.exists(QUERY_CACHE_PATH):
        with open(QUERY_CACHE_PATH, "r") as rPrevQuerys:
            lines = rPrevQuerys.readlines()
            rPrevQuerys.close()
    with open(QUERY_CACHE_PATH, "w") as wPrevQuerys:
        # adding to query history
        if f"{query}\n" not in lines:
            if len(lines) >= 10:
                lines.pop(0)
            lines.insert(0, f"{query}\n")
        else:
            idx = lines.index(f"{query}\n")
            lines.pop(idx)
            lines.insert(0, f"{query}\n")
        wPrevQuerys.writelines(lines)
        wPrevQuerys.close()
    return query


def getWallpaperFromDir():
    formatted_outputs = []
    for dirpath, dirnames, files in os.walk(WALLPAPER_DIR_PATH):
        for file in files:
            file_path = dirpath + "/" + file
            formatted_outputs.append(f"{file_path}\x00icon\x1f{file_path}")

    encoded_outputs = "\n".join(formatted_outputs).encode("utf-8")
    wallpaper = s.check_output(
        f'echo -en "{encoded_outputs}" | rofi -dmenu -p "Wallpaper" -theme-str "#entry {{ placeholder: \'Wallpaper to apply..\'; }}" ',
        shell=True,
        text=True,
    )
    notifyWallpaper("Wallpaper From Dir", [f"Wallpaper: {os.path.basename(wallpaper)}"])
    return wallpaper.strip("b'")


def setWallpaper(wallpaper):
    s.run("fish -c 'set -e -U WALLPAPER'", shell=True)
    s.run(f"fish -c 'set -Ux WALLPAPER {wallpaper}'", shell=True)
    s.run(
        f'fish -c "swww img {wallpaper.strip()} --transition-type grow --transition-pos (hyprctl cursorpos) --transition-duration 1" ',
        shell=True,
    )
    s.run("fish -c 'echo $WALLPAPER >~/.config/wallpaper.txt'", shell=True)
    os._exit(0)


commandMenu = f'echo "{WALLPAPER_CHOICE_ROFI_MENU}" | rofi -dmenu -i -p "Select mode" -theme-str "listview {{lines: 3;}}" '

wallpaperChoiceMode = (
    s.check_output(commandMenu, shell=True, text=True).strip().split(".")[0]
)


if wallpaperChoiceMode == "1":
    w = getWallpaperFromDir()
    setWallpaper(w)
elif wallpaperChoiceMode == "2":
    wallhavenOption = getWallhavenOption()
    query = ""
    if wallhavenOption == "1":
        getWallpaperFromWallhaven()
    if wallhavenOption == "2":
        query = getQueryHistory()
        print("heere")
        print(query)
        getWallpaperFromWallhaven(query=query)
    if wallhavenOption == "3":
        query = getPrevQuerys(QUERY_CACHE_PATH).splitlines()
        getWallpaperFromWallhaven(query[0])
    if wallhavenOption == "4":
        wallpaperLocalPath = f"{HOME_PATH}/.local/share/backgrounds/"
        if (
            os.path.exists(wallpaperLocalPath)
            and len(os.listdir(wallpaperLocalPath)) >= 1
        ):
            os.chdir(wallpaperLocalPath)
            for file in os.listdir(wallpaperLocalPath):
                print(f"{WALLPAPER_DIR_PATH}/{file}")
                os.rename(file, f"{WALLPAPER_DIR_PATH}/{file}")
                setWallpaper(f"{WALLPAPER_DIR_PATH}/{file}")
                notifyWallpaper("Wallpaper Moved", [f"Wallpaper: {file}"])
                print("file: " + file)
        else:
            notifyWallpaper("Error", ["No wallpapers found to move."])

elif wallpaperChoiceMode == "3":
    print("Exiting...")
    s.run('notify-send "Quiting Wallpaper Menu..."', shell=True)
    os._exit(0)
