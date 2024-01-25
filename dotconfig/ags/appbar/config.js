import App from "resource:///com/github/Aylur/ags/app.js";
import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
import { CenterBox, Window } from "resource:///com/github/Aylur/ags/widget.js";
import { Left } from "./left.js";
import { Center } from "./center.js";
import { Right } from "./right.js";

const Bar = ({ monitor } = {}) =>
  Window({
    name: "appbar", // name has to be unique
    className: "bar",
    monitor,
    // margins: [5, 5, 5, 5],
    margins: [0, 0, 0, 0],
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: CenterBox({
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });

const css = `${App.configDir}/style.css`;
export default {
  style: css,
  windows: [Bar()],
};

Utils.monitorFile(
  `${App.configDir}`,
  function () {
    App.resetCss();
    App.applyCss(css);
  },
  "directory",
);
