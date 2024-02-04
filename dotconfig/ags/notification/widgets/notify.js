import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Variable from "resource:///com/github/Aylur/ags/variable.js";

import { exec } from "resource:///com/github/Aylur/ags/utils.js";
const notiData = Variable([]);

function parseNotifications() {
  notiData.setValue([]);
  const notifications = exec("dunstctl history");
  const notiCount = JSON.parse(notifications).data[0].length;
  const notis = JSON.parse(notifications).data[0];
  if (notiCount > 0) {
    notiData.setValue(
      notis.map((noti) => {
        return {
          appName: noti["appname"].data,
          // appName: noti["app-name"].data, for mako
          appSummary: noti["summary"].data,
          appBody: noti["body"].data,
          appId: noti["id"].data,
        };
      }),
    );
    console.log(notiData.value);
  }
}
parseNotifications();

const notiWidget = (name, sum, body, id) =>
  Widget.Box({
    vertical: true,
    children: [
      Widget.EventBox({
        onPrimaryClick: () => {
          exec(`dunstctl history-rm ${id}`);
          notiData.setValue(notiData.value.filter((noti) => noti.appId != id));
        },
        child: Widget.Box({
          vertical: true,
          className: "noti-widget",
          children: [
            Widget.Label({ label: String(name) }),
            Widget.Label({ label: String(sum) }),
            Widget.Label({ label: String(body) }),
            // Widget.Label({ label: String(id) }),
          ],
        }),
      }),
    ],
  });

export const Noti = () =>
  Widget.Scrollable({
    className: "noti-scroll",
    css: "min-width: 600px; min-height: 200px;",
    child: Widget.Box({
      className: "noti-box",
      vertical: true,
      spacing: 10,
      setup: (self) =>
        self.hook(notiData, () => {
          const arrayNotificationsWidget = [];
          console.log(notiData.value);
          console.log(notiData.value.length);
          if (notiData.value.length === 0) {
            arrayNotificationsWidget.push(Widget.Label({ label: "No notifications" }));
          } else {
            for (const noti of notiData.value) {
              arrayNotificationsWidget.push(
                notiWidget(
                  noti.appName,
                  noti.appSummary,
                  noti.appBody,
                  noti.appId,
                ),
              );
            }
          }
            self.children = arrayNotificationsWidget;
        }),
    }),
  });
