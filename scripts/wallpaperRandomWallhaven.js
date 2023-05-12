#!/usr/bin/env node

const { spawn } = require("child_process");
const fs = require("fs");
const path = require("path");
const client = require("https");
const pathBG = "/home/caue/.local/share/backgrounds/";

const downloadImage = (url, filepath) => {
  client.get(url, (res) => {
    res.pipe(fs.createWriteStream(filepath));
  });
};

const deletePreviousWallpapers = () => {
  fs.readdir(pathBG, (err, files) => {
    if (err) throw err;

    for (const file of files) {
      fs.unlink(path.join(pathBG, file), (err) => {
        if (err) throw err;
      });
    }
  });
};

const setBG = (image) => {
  spawn("killall", ["swaybg"]).stdin.end();
  spawn("swaybg", ["-i", image, "-m", "fill"]).stdin.end();
  spawn("fish", ["-c", "set -e -U WALLPAPER"]).stdin.end();
  spawn("fish", ["-c", `set -Ux WALLPAPER ${image}`]).stdin.end();
  spawn("fish", [
    "-c",
    `echo ${image} > /home/caue/.config/wallpaper.txt`,
  ]).stdin.end();
};

const fetchApi = async () => {
  const response = await fetch(
    "https://wallhaven.cc/api/v1/search?sorting=random"
  );
  const jsonData = await response.json();
  console.log(jsonData);
  const pathImage = jsonData.data[0].path;
  const id = jsonData.data[0].id;
  const fileType = jsonData.data[0].file_type.replace("image/", "");
  const filePath = `${pathBG}wallhaven-${id}.${fileType}`;

  deletePreviousWallpapers();
  downloadImage(pathImage, filePath);
  setTimeout(() => {
    setBG(filePath);
  }, 1000);
};

fetchApi();
