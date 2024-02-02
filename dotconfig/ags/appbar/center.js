import { Box } from "resource:///com/github/Aylur/ags/widget.js";
import { Workspace } from "./widgets/workspace.js";
import { WindowTitle } from "./widgets/windowTitle.js";

export const Center = () =>
  Box({
    children: [WindowTitle(80)],
  });
