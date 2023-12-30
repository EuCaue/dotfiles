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

const dispatch = (ws) => Hyprland.sendMessage(`dispatch workspace ${ws}`);

const WorkspaceButton = (id) =>
  Button({
    onClicked: () => dispatch(id),
    child: Box({
      className: "workspace-box",
      children: [
        Label({ label: `${id} ` }),
        Label({
          justification: "center",
          label: `${workspacesIcons.get(String(id)) ?? ""} `,
          className: "workspace-icon",
        }),
      ],
    }),
    className:
      Hyprland.active.workspace.id == Number(id)
        ? "focused workspace"
        : "workspace",
  });

const Workspaces = () =>
  EventBox({
    onScrollUp: () => dispatch("+1"),
    onScrollDown: () => dispatch("-1"),
    onHover: (box) => {
      box.window.set_cursor(Gdk.Cursor.new_from_name(gdkDisplay, "pointer"));
    },
    child: Box({
      className: "workspaces",
    }).hook(Hyprland, (self) => {
      const workspacesWithWindows = Object.values(Hyprland.workspaces)
        .filter((w) => {
          return !w.name.startsWith("special");
        })
        .sort((a, b) => a.id - b.id);

      self.children = workspacesWithWindows.map((i) => WorkspaceButton(i.id));
    }),
  });

export const Center = () =>
  Box({
    children: [Workspaces()],
  });
