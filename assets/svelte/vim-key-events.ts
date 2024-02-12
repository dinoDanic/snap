export type Direction = "up" | "down" | "left" | "right";

const direction = (event: KeyboardEvent): Direction | null => {
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
  return null
}

export const vimKeyEvents = {
  direction,
};
