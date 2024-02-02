import Gdk from "gi://Gdk";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import {
  Box,
  EventBox,
  Label,
} from "resource:///com/github/Aylur/ags/widget.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { gdkDisplay } from "../consts.js";

export const Volume = () =>
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
