import {
  Box,
  EventBox,
  Label,
} from "resource:///com/github/Aylur/ags/widget.js";

export const Sep = () =>
  Box({
    children: [Label({ label: "|", className: "sep" })],
  });
