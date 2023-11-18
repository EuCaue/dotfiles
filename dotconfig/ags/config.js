// importing
import Gdk from "gi://Gdk";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import Mpris from "resource:///com/github/Aylur/ags/service/mpris.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";
import {
  Box,
  Button,
  EventBox,
  Stack,
  Label,
  Icon,
  CenterBox,
  Window,
  Slider,
  ProgressBar,
} from "resource:///com/github/Aylur/ags/widget.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
const display = Gdk.Display.get_default();

// import statements are long, so there is also the global ags object you can import from
// const { Hyprland, Notifications, Mpris, Audio, Battery } = ags.Service;
// const { App } = ags;
// const { exec } = ags.Utils;
// const {
//     Box, Button, Stack, Label, Icon, CenterBox, Window, Slider, ProgressBar
// } = ags.Widget;

// every widget is a subclass of Gtk.<widget>
// with a few extra available properties
// for example Box is a subclass of Gtk.Box

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, just make it a function
// then you can use it by calling simply calling it

const workspacesIcons = new Map([
  ["1", "󰈹"],
  ["2", ""],
  ["3", "󰅴"],
  ["4", "󰖟"],
  ["5", "󰝚"],
  ["6", "󰊗"],
  ["7", "󱞁"],
  ["8", "󱁯"],
]);

const Workspaces = () =>
  EventBox({
    onHover: (box) => {
      box.window.set_cursor(Gdk.Cursor.new_from_name(display, "pointer"));
    },
    // onHoverLost: box => {
    //      box.window.set_cursor(null);
    //  },
    child: Box({
      className: "workspaces",
      connections: [
        [
          Hyprland,
          (box) => {
            const workspacesWithWindows = Object.values(Hyprland.workspaces)
              .filter((w) => {
                return !w.name.startsWith("special");
              })
              .sort((a, b) => a.id - b.id);

            box.children = workspacesWithWindows.map((i) => {
              return Button({
                onClicked: () =>
                  execAsync(`hyprctl dispatch workspace ${Number(i.id)}`),
                child: Box({
                  className: "workspace-box",
                  children: [
                    Label({ label: `${i.id} ` }),
                    Label({
                      justification: "center",
                      label: `${workspacesIcons.get(String(i.id)) ?? ""} `,
                      className: "workspace-icon",
                    }),
                  ],
                }),
                className:
                  Hyprland.active.workspace.id == Number(i.id)
                    ? "focused workspace"
                    : "workspace",
              });
            });
          },
        ],
      ],
    }),
  });

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

const systemtray = Box({
  className: "systemtray",
  connections: [
    [
      SystemTray,
      (box) => {
        box.children = SystemTray.items.map((item) =>
          Button({
            child: Icon(),
            onPrimaryClick: (_, event) => item.activate(event),
            onHover: (box) => {
              box.window.set_cursor(
                Gdk.Cursor.new_from_name(display, "pointer"),
              );
            },
            onHoverLost: (box) => {
              box.window.set_cursor(null);
            },
            onSecondaryClick: (_, event) => item.openMenu(event),
            connections: [
              [
                item,
                (button) => {
                  button.child.icon = item.icon;
                  button.tooltipMarkup = item.tooltipMarkup;
                },
              ],
            ],
          }),
        );
      },
    ],
  ],
});

let showDateOrTime = Variable(true);

const Clock = () =>
  EventBox({
    onPrimaryClick: () => showDateOrTime.setValue(!showDateOrTime.value),
    onHover: (box) => {
      box.window.set_cursor(Gdk.Cursor.new_from_name(display, "pointer"));
    },
    onHoverLost: (box) => {
      box.window.set_cursor(null);
    },
    child: Box({
      className: "clock",
      children: [
        Label({
          justification: "center",
          className: "clock-icon",
          connections: [
            [
              showDateOrTime,
              (label) => (label.label = showDateOrTime.value ? "󰥔 " : "󰃮 "),
            ],
          ],
        }),
        Label({
          justification: "center",
          connections: [
            [
              1000,
              (label) =>
                showDateOrTime.value
                  ? execAsync(["date", "+%H:%M:%S"])
                      .then((date) => (label.label = `${date}`))
                      .catch(console.error)
                  : execAsync(["date", "+%d-%a %m-%b %y"])
                      .then((date) => (label.label = `${date}`))
                      .catch(console.error),
            ],
            [
              showDateOrTime,
              (label) =>
                showDateOrTime.value
                  ? execAsync(["date", "+%H:%M:%S"])
                      .then((date) => (label.label = `${date}`))
                      .catch(console.error)
                  : execAsync(["date", "+%d-%a %m-%b %y"])
                      .then((date) => (label.label = `${date}`))
                      .catch(console.error),
            ],
          ],
        }),
      ],
    }),
  });

// we don't need dunst or any other notification daemon
// because ags has a notification daemon built in
const Notification = () =>
  Box({
    className: "notification",
    children: [
      Icon({
        icon: "preferences-system-notifications-symbolic",
        connections: [
          [
            Notifications,
            (icon) => (icon.visible = Notifications.popups.size > 0),
          ],
        ],
      }),
      Label({
        connections: [
          [
            Notifications,
            (label) => {
              // notifications is a map, to get the last elememnt lets make an array
              label.label =
                Array.from(Notifications.popups.values())?.pop()?.summary || "";
            },
          ],
        ],
      }),
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
      box.window.set_cursor(Gdk.Cursor.new_from_name(display, "pointer"));
    },
    onHoverLost: (box) => {
      box.window.set_cursor(null);
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

// layout of the bar
const Left = () =>
  Box({
    className: "left",
    children: [Clock(), systemtray],
  });

const Center = () =>
  Box({
    children: [Workspaces(), Notification()],
  });

const Right = () =>
  Box({
    hpack: "end",
    children: [BatteryLabel(), ClientTitle(), Volume()],
  });

const Bar = ({ monitor } = {}) =>
  Window({
    name: `bar${monitor || ""}`, // name has to be unique
    className: "bar",
    monitor,
    //margin: [5, 15, 0, 15],
    margins: [0, 0, 0, 0],
    anchor: ["top", "left", "right"],
    exclusive: true,
    child: CenterBox({
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });

export default {
  style: App.configDir + "/style.css",
  windows: [Bar()],
};
