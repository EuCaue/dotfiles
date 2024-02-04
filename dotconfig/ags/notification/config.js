import App from "resource:///com/github/Aylur/ags/app.js";
import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
import { Box, Label, Window } from "resource:///com/github/Aylur/ags/widget.js";
import { Noti } from "./widgets/notify.js";

const Notify = ({ monitor } = {}) =>
  Window({
    name: "notification-bar", // name has to be unique
    className: "notifiy-bar",
    monitor,
    margins: [0, 0, 0, 0],
    anchor: ["top"],
    exclusivity: "normal",
    popup: true,
    child: Noti(),
  });

// const css = `${App.configDir}/style.css`;
export default {
  // style: css,
  windows: [Notify()],
};
//
// Utils.monitorFile(
//   `${App.configDir}`,
//   function () {
//     App.resetCss();
//     App.applyCss(css);
//   },
//   "directory",
// );
