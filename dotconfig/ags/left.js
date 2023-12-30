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

import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
let showDateOrTime = Variable(true);
import { gdkDisplay } from "./consts.js";

function dateOrTime(label) {
  showDateOrTime.value
    ? execAsync(["date", "+%H:%M:%S"])
        .then((date) => (label.label = `${date}`))
        .catch(console.error)
    : execAsync(["date", "+%b %d"])
        .then((date) => (label.label = `${date}`))
        .catch(console.error);
}

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
        }).hook(showDateOrTime, (self) => {
          self.label = showDateOrTime.value ? "󰥔 " : "󰃮 ";
        }),

        Label({
          justification: "center",
        })
          .hook(showDateOrTime, (self) => {
            self.tooltipText = showDateOrTime.value
              ? exec("date +'%H:%M:%S'")
              : exec("date +'%b %d'");
            dateOrTime(self);
          })
          .poll(1000, (self) => dateOrTime(self)),
      ],
    }),
  });

const SysTrayItem = (item) =>
  Button({
    onHover: (btn) => {
      btn.window.set_cursor(Gdk.Cursor.new_from_name(gdkDisplay, "pointer"));
    },
    onHoverLost: (btn) => {
      btn.window.set_cursor(null);
    },
    child: Icon().bind("icon", item, "icon"),
    tooltipMarkup: item.bind("tooltip-markup"),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
  });

const Systemtray = () =>
  Box({ className: "systemtray" }).bind("children", SystemTray, "items", (i) =>
    i.map(SysTrayItem),
  );

export const Left = () =>
  Box({
    className: "left",
    children: [Clock(), Systemtray()],
  });
