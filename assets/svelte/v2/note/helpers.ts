export function set_cursor_to_end(node: HTMLElement) {
  const setSelectionRange = () => {
    const range = document.createRange();
    const sel = window.getSelection();

    if (sel) {
      range.selectNodeContents(node);
      range.collapse(false); // false to collapse the range to its end point

      sel.removeAllRanges();
      sel.addRange(range);
    }
  };

  node.addEventListener("focus", setSelectionRange);

  return {
    destroy() {
      node.removeEventListener("focus", setSelectionRange);
    },
  };
}
