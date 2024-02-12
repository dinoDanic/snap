<script lang="ts">
  import { Direction, vimKeyEvents } from "$lib/vim-key-events";
  import { onMount } from "svelte";

  onMount(() => {
    document.addEventListener("keydown", handleKeyDown);
    return () => {
      document.removeEventListener("keydown", handleKeyDown);
    };
  });

  function handleKeyDown(e: KeyboardEvent): void {
    const direction = vimKeyEvents.direction(e);
    if (direction) {
      e.preventDefault(); // Prevent the default action to avoid any side effects
      focusElement(direction);
    }
  }

  function focusElement(direction: Direction): void {
    const focusableSelectors =
      'a, div, button, input, textarea, select, [tabindex]:not([tabindex="-1"])';

    const focusableElements: HTMLElement[] = Array.from(
      document.querySelectorAll(focusableSelectors),
    );

    const activeElement = document.activeElement as HTMLElement;

    const currentIndex = focusableElements.indexOf(activeElement);
    let targetIndex = currentIndex;

    if (direction === "down") {
      targetIndex = (currentIndex + 1) % focusableElements.length;
    } else if (direction === "up") {
      targetIndex =
        (currentIndex - 1 + focusableElements.length) %
        focusableElements.length;
    }

    focusableElements[targetIndex]?.focus();
  }
</script>
