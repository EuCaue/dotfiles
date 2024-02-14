import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";

export const Noti = () =>
  Widget.Button({
    className: "default-box",
    onSecondaryClick: () => exec("swaync-client -C"),
    onPrimaryClick: () => {
      execAsync(["swaync-client", "-t"]);
    },
    child: Widget.Label().poll(5000, (self) => {
      execAsync(["swaync-client", "-c"])
        .then((notis) => {
          console.log(notis);
          if (Number(notis.trim()) > 0) {
            self.label = `󱅫 ${notis.trim()}`;
          } else {
            self.label = "󰂚";
          }
        })
        .catch(console.error);
    }),
  });
