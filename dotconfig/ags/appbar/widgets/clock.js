import Gdk from "gi://Gdk";
import Variable from "resource:///com/github/Aylur/ags/variable.js";
import {
  Box,
  EventBox,
  Label,
} from "resource:///com/github/Aylur/ags/widget.js";

import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { gdkDisplay } from "../consts.js";

const showTimeOrDate = Variable(true);

function dateOrTime(label) {
  showTimeOrDate.value
    ? execAsync(["date", "+%H:%M:%S"])
        .then((date) => (label.label = `${date}`))
        .catch(console.error)
    : execAsync(["date", "+%b %d %A"])
        .then((date) => (label.label = `${date}`))
        .catch(console.error);
}

export const Clock = () =>
  EventBox({
    onPrimaryClick: () => showTimeOrDate.setValue(!showTimeOrDate.value),

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
        })
          .hook(showTimeOrDate, (self) => {
            dateOrTime(self);
            self.tooltipText = showTimeOrDate.value
              ? exec("date +'%H:%M:%S'")
              : exec("date +'%b %d'");
          })
          .poll(1000, (self) => dateOrTime(self)),
        Label({
          justification: "center",
          className: "clock-icon",
        }).hook(showTimeOrDate, (self) => {
          // self.label = showTimeOrDate.value ? " 󰥔 " : " 󰃮 ";
        }),
      ],
    }),
  });
