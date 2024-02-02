import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import { Label } from "resource:///com/github/Aylur/ags/widget.js";

function activeWindowTitle(self, maxChars) {
  const minChars = 0;
  const title = Hyprland.active.client.title;
  if (title.length >= maxChars) {
    return title.slice(minChars, maxChars) + "…";
  }
  return title;
}

export const WindowTitle = (maxChars = 30) =>
  Label({
    className: "client-title default-box",
  }).hook(Hyprland, (self) => {
    self.label = activeWindowTitle(self, maxChars);
    self.tooltipText = Hyprland.active.client.title;
  });
