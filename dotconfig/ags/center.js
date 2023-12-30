import Gdk from "gi://Gdk";
import {
  Box,
  Button,
  EventBox,
  Label,
  Icon,
  CenterBox,
  Window,
} from "resource:///com/github/Aylur/ags/widget.js";

import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { gdkDisplay } from "./consts.js";

const workspacesIcons = new Map([
  ["1", "󰈹"],
  ["2", ""],
  ["3", "󰅴"],
  ["4", "󰖟"],
  ["5", "󰝚"],
  ["6", "󰊗"],
  ["7", "󱞁"],
  ["8", "󱁯"],
]);

const Workspaces = () =>
  EventBox({
    onHover: (box) => {
      box.window.set_cursor(Gdk.Cursor.new_from_name(gdkDisplay, "pointer"));
    },
    child: Box({
      className: "workspaces",
      connections: [
        [
          Hyprland,
          (box) => {
            const workspacesWithWindows = Object.values(Hyprland.workspaces)
              .filter((w) => {
                return !w.name.startsWith("special");
              })
              .sort((a, b) => a.id - b.id);

            box.children = workspacesWithWindows.map((i) => {
              return Button({
                onClicked: () =>
                  execAsync(`hyprctl dispatch workspace ${Number(i.id)}`),
                child: Box({
                  className: "workspace-box",
                  children: [
                    Label({ label: `${i.id} ` }),
                    Label({
                      justification: "center",
                      label: `${workspacesIcons.get(String(i.id)) ?? ""} `,
                      className: "workspace-icon",
                    }),
                  ],
                }),
                className:
                  Hyprland.active.workspace.id == Number(i.id)
                    ? "focused workspace"
                    : "workspace",
              });
            });
          },
        ],
      ],
    }),
  });

export const Center = () =>
  Box({
    children: [Workspaces()],
  });
