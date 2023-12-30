import Gdk from "gi://Gdk";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";

import {
  Box,
  EventBox,
  Label,
} from "resource:///com/github/Aylur/ags/widget.js";

import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";

import { gdkDisplay } from "./consts.js";

const batteryIcon = () => {
  const per = Math.abs(Math.floor(Battery.percent / 10) * 10);
  let icon;

  if (per > 90) {
    icon = " ";
  } else if (per > 80) {
    icon = " ";
  } else if (per > 70) {
    icon = " ";
  } else if (per > 60) {
    icon = " ";
  } else if (per > 50) {
    icon = " ";
  } else if (per > 40) {
    icon = " ";
  } else if (per > 30) {
    icon = " ";
  } else if (per > 20) {
    icon = " ";
  } else if (per > 10) {
    icon = " ";
  } else if (per > 0) {
    icon = " ";
  } else {
    icon = " ";
  }
  return icon;
};

const activeWindowTitle = () => {
  const min = 0;
  const max = 30;
  const title = Hyprland.active.client.title;
  if (title.length >= max) {
    return title.slice(min, max) + "…";
  }

  return title;
};

const ClientTitle = () =>
  Label({
    className: "client-title default-box",
    connections: [
      [
        Hyprland,
        (label) => {
          label.label = activeWindowTitle();
        },
      ],
    ],
  });

const Volume = () =>
  EventBox({
    onScrollUp: () => {
      execAsync(["fish", "-c", "$HOME/.config/ags/volume.fish up"])
        .then((v) => console.log(v))
        .catch(console.error);
    },

    onScrollDown: () => {
      execAsync(["fish", "-c", "$HOME/.config/ags/volume.fish down"])
        .then((v) => console.log(v))
        .catch(console.error);
    },

    onHover: (box) => {
      box.window.set_cursor(Gdk.Cursor.new_from_name(gdkDisplay, "pointer"));
    },
    onHoverLost: (box) => {
      box.window.set_cursor(null);
    },

    onPrimaryClick: () => {
      exec("pavucontrol");
    },
    onSecondaryClick: () => {
      exec("pactl set-sink-volume @DEFAULT_SINK@ 40%");
    },
    child: Box({
      className: "default-box",
      children: [
        Label({
          className: "speaker-text",
          connections: [
            [
              Audio,
              (label) => {
                const isMuted = Audio.speaker?.stream?.isMuted;
                if (isMuted) {
                  label.label = "";
                  return;
                }
                const volume = Math.round(Audio.speaker?.volume * 100);
                label.label = `${volume}% `;
              },
              "speaker-changed",
            ],
          ],
        }),

        Label({
          className: "audio-icon",
          connections: [
            [
              Audio,
              (label) => {
                const isMuted = Audio.speaker?.stream?.isMuted;
                if (isMuted) {
                  label.label = "󰆪 ";
                  return;
                }
                label.label = `󰋋 `;
              },
              "speaker-changed",
            ],
          ],
        }),

        Label({
          className: "mic-text",
          connections: [
            [
              Audio,
              (label) => {
                // console.log("mic", Audio.microphones);
                const isMuted = Audio.microphone?.stream?.isMuted;
                if (isMuted) {
                  label.label = ``;
                  return;
                }
                const volume = Math.round(Audio.microphone?.volume * 100);
                label.label = `${volume || ""}% `;
              },
              "microphone-changed",
            ],
          ],
        }),

        Label({
          className: "audio-icon",
          connections: [
            [
              Audio,
              (label) => {
                const isMuted = Audio.microphone?.stream?.isMuted;
                if (isMuted) {
                  label.label = `󰍭`;
                  return;
                }
                label.label = `󰍬`;
              },
              "microphone-changed",
            ],
          ],
        }),
      ],
    }),
  });

const BatteryLabel = () =>
  Box({
    className: "battery",
    children: [
      Label({
        connections: [
          [
            Battery,
            (label) => {
              label.label = batteryIcon();
            },
          ],
        ],
      }),
    ],
  });

export const Right = () =>
  Box({
    hpack: "end",
    children: [BatteryLabel(), ClientTitle(), Volume()],
  });
