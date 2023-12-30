import App from "resource:///com/github/Aylur/ags/app.js";
import { CenterBox, Window } from "resource:///com/github/Aylur/ags/widget.js";

import { Left } from "./left.js";
import { Center } from "./center.js";
import { Right } from "./right.js";

const Bar = ({ monitor } = {}) =>
  Window({
    name: `bar${monitor || ""}`, // name has to be unique
    className: "bar",
    monitor,
    //margin: [5, 15, 0, 15],
    margins: [0, 0, 0, 0],
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
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
