import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import { Box, Label } from "resource:///com/github/Aylur/ags/widget.js";

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

export const BatteryLabel = () =>
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
