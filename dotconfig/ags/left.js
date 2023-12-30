import Gdk from "gi://Gdk";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";
import {
  Box,
  Button,
  EventBox,
  Label,
  Icon,
} from "resource:///com/github/Aylur/ags/widget.js";

import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
let showDateOrTime = Variable(true);
import { gdkDisplay } from "./consts.js";

const Clock = () =>
  EventBox({
    onPrimaryClick: () => showDateOrTime.setValue(!showDateOrTime.value),
    onHover: (box) => {
      box.window.set_cursor(Gdk.Cursor.new_from_name(gdkDisplay, "pointer"));
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
                Gdk.Cursor.new_from_name(gdkDisplay, "pointer"),
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

export const Left = () =>
  Box({
    className: "left",
    children: [Clock(), systemtray],
  });
