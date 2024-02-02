import Gdk from "gi://Gdk";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import {
  Box,
  EventBox,
  Label,
} from "resource:///com/github/Aylur/ags/widget.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { gdkDisplay } from "./consts.js";
import { BatteryLabel } from "./widgets/battery.js";
import { WindowTitle } from "./widgets/windowTitle.js";
import { Volume } from "./widgets/volume.js";
import { Systemtray } from "./widgets/systray.js";
import { Clock } from "./widgets/clock.js";
import { Sep } from "./widgets/sep.js";

export const Right = () =>
  Box({
    hpack: "end",
    children: [BatteryLabel(), Systemtray(), Sep(), Clock(), Sep(), Volume()],
  });
