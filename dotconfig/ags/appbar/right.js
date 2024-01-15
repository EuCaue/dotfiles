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

function batteryIcon(per) {
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
}

function activeWindowTitle(self) {
  const minChars = 0;
  const maxChars = 30;
  const title = Hyprland.active.client.title;
  if (title.length >= maxChars) {
    return title.slice(minChars, maxChars) + "…";
  }
  return title;
}

const CurrentWindowTitle = () =>
  Label({
    className: "client-title default-box",
  }).hook(Hyprland, (self) => {
    self.label = activeWindowTitle(self);
    self.tooltipText = Hyprland.active.client.title;
  });

const Volume = () =>
  EventBox({
    onScrollUp: () => {
      execAsync(["fish", "-c", "audio.fish up"])
        .then((v) => console.log(v))
        .catch(console.error);
    },

    onScrollDown: () => {
      execAsync(["fish", "-c", "audio.fish down"])
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
      exec("pactl set-sink-mute @DEFAULT_SINK@ toggle");
    },
    onSecondaryClick: () => {
      exec("pactl set-sink-volume @DEFAULT_SINK@ 40%");
    },
    child: Box({
      className: "default-box",
      children: [
        Box({
          setup: (self) => {
            self.add(
              Label({
                className: "speaker-text",
              }).hook(
                Audio,
                function (self, ...args) {
                  const isMuted = Audio.speaker?.stream?.isMuted;
                  if (isMuted) {
                    self.label = "";
                    return;
                  }
                  const volume = Math.round(Audio.speaker?.volume * 100);
                  self.label = `${volume}% `;
                },
                "speaker-changed",
              ),
            );

            self.add(
              Label({
                className: "audio-icon",
              }).hook(
                Audio,
                (self, ...args) => {
                  const isMuted = Audio.speaker?.stream?.isMuted;
                  if (isMuted) {
                    self.label = "󰆪 ";
                    return;
                  }
                  self.label = `󰋋 `;
                },
                "speaker-changed",
              ),
            );
          },
        }).hook(
          Audio,
          (self, ...args) => {
            const volume = Math.round(Audio.speaker?.volume * 100);
            self.tooltipText = `Volume: ${volume}%`;
          },
          "speaker-changed",
        ),

        Box({
          setup: (self) => {
            self.add(
              Label({
                className: "mic-text",
              }).hook(
                Audio,
                (self) => {
                  const isMuted = Audio.microphone?.stream?.isMuted;
                  if (isMuted) {
                    self.label = ``;
                    return;
                  }
                  const volume = Math.round(Audio.microphone?.volume * 100);
                  self.label = `${volume || ""}% `;
                },
                "microphone-changed",
              ),
            );
            self.add(
              Label({
                className: "audio-icon",
              }).hook(
                Audio,
                (self) => {
                  const isMuted = Audio.microphone?.stream?.isMuted;
                  if (isMuted) {
                    self.label = `󰍭`;
                    return;
                  }
                  self.label = `󰍬`;
                },
                "microphone-changed",
              ),
            );
          },
        }).hook(
          Audio,
          (self) => {
            const volume = Math.round(Audio.microphone?.volume * 100);
            self.tooltipText = `Microphone: ${volume}%`;
          },
          "microphone-changed",
        ),
      ],
    }),
  });

const BatteryLabel = () =>
  Box({
    className: "battery",
    children: [
      Label().hook(Battery, (self) => {
        const batteryPercent = Battery.percent;
        self.tooltipText = `Battery: ${batteryPercent}%`;
        self.label = batteryIcon(batteryPercent);
      }),
    ],
  });

export const Right = () =>
  Box({
    hpack: "end",
    children: [BatteryLabel(), CurrentWindowTitle(), Volume()],
  });
