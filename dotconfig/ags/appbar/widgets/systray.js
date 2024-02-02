import Gdk from "gi://Gdk";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import { Box, Button, Icon } from "resource:///com/github/Aylur/ags/widget.js";

import { gdkDisplay } from "../consts.js";

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

export const Systemtray = () =>
  Box({ className: "systemtray" }).bind("children", SystemTray, "items", (i) =>
    i.map(SysTrayItem),
  );
