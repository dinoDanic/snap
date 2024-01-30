type Direction = "up" | "down" | "left" | "right";

export const vimKeyEvents = (event: KeyboardEvent): Direction => {
  if (
    (event.ctrlKey && event.key === "n") ||
    (event.ctrlKey && event.key === "j") ||
    event.key === "ArrowDown"
  ) {
    return "down";
  } else if (
    (event.ctrlKey && event.key === "p") ||
    (event.ctrlKey && event.key === "k") ||
    event.key === "ArrowUp"
  ) {
    return "up";
  }
};
