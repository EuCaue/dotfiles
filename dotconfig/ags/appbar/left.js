import { Box } from "resource:///com/github/Aylur/ags/widget.js";

import { Workspace } from "./widgets/workspace.js";

export const Left = () =>
  Box({
    className: "left",
    children: [Workspace()],
  });
