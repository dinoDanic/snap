<script lang="ts">
  import CommandLite from "$lib/components/ui/command-lite/command-lite.svelte";
  import { Note } from "$lib/types";
  import { cn } from "$lib/utils";
  import { Live } from "live_svelte";
  import { note_settings } from "./settings";

  export let note: Note;
  export let live: Live;

  let editableDiv: HTMLElement;

  let text_content = note.note || "";

  $: isActionTime = text_content.includes(note_settings.action_time_trigger);

  function setCursorToEnd(node: HTMLElement) {
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

  function focusEditableDiv() {
    editableDiv.focus();
  }

  const on_blur = () => {
    if (text_content !== note.note || "") {
      const includesTrigger = text_content.includes(
        note_settings.action_time_trigger,
      );
      if (includesTrigger) return;
      live.pushEvent("update_note", { ...note, note: text_content });
    }
  };
</script>

<div
  bind:this={editableDiv}
  class={cn("focus:outline-none py-sm", note.class)}
  contenteditable="true"
  use:setCursorToEnd
  bind:textContent={text_content}
  on:blur={on_blur}
/>
{#if isActionTime}
  <CommandLite {focusEditableDiv} bind:text_content {note} {live} />
{/if}
