import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";
const isNotWindowOpen = Variable(false);

export const Noti = () =>
  Widget.Button({
    className: "default-box",
    onSecondaryClick: () => exec("dunstctl history-clear"),
    onPrimaryClick: () => {
      isNotWindowOpen.setValue(!isNotWindowOpen.value);
      if (isNotWindowOpen.value) {
        execAsync([
          "ags",
          "--config",
          "/home/caue/.config/ags/notification/config.js",
          "--bus-name",
          "noti",
        ]).then((v) => console.log(v));
      } else {
        exec("ags --quit --bus-name noti");
      }
    },
    child: Widget.Label().poll(5000, (self) => {
      execAsync(["dunstctl", "history"])
        .then((notis) => {
          const notiCount = JSON.parse(notis).data[0].length;
          if (notiCount > 0) {
            self.label = `󱅫 ${notiCount}`;
          } else {
            self.label = "󰂚";
          }
        })
        .catch(console.error);
    }),
  });
