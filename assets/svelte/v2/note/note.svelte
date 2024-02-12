<script lang="ts">
  import CommandLite from "$lib/components/ui/command-lite/command-lite.svelte";
  import { Note } from "$lib/types";
  import { cn } from "$lib/utils";
  import { Live } from "live_svelte";
  import { note_settings } from "./settings";
  import { onMount } from "svelte";

  export let note: Note;
  export let live: Live;

  let editableDiv: HTMLElement;

  let text_content = note.note || "";

  $: is_action_time = text_content.includes(note_settings.action_time_trigger);

  const focusEditableDiv = () => editableDiv.focus();

  const on_blur = () => {
    if (text_content !== note.note || "") {
      const includesTrigger = text_content.includes(
        note_settings.action_time_trigger,
      );
      if (includesTrigger) return;
      live.pushEvent("update_note", { ...note, note: text_content });
    }
  };

  function handleKeyDown(e: KeyboardEvent): void {
    if (e.key === "Enter") {
      console.log("enter");
    } else if (e.key === "Backspace" && text_content === "") {
      console.log("delete_note");
    }
  }

  onMount(() => {
    document.addEventListener("keydown", handleKeyDown);
    return () => {
      document.removeEventListener("keydown", handleKeyDown);
    };
  });
</script>

<!-- svelte-ignore a11y-no-noninteractive-tabindex -->
<!-- <div -->
<!--   bind:this={editableDiv} -->
<!--   class={cn("focus:outline-none focus:translate-x-1 transition-transform py-sm", note.class)} -->
<!--   contenteditable="true" -->
<!--   placeholder="Type here..." -->
<!--   use:set_cursor_to_end -->
<!--   bind:textContent={text_content} -->
<!--   on:blur={on_blur} -->
<!-- /> -->

<input
  bind:value={text_content}
  bind:this={editableDiv}
  on:blur={on_blur}
  class={cn(
    "w-full bg-transparent focus:outline-none focus:translate-x-1 transition-transform py-sm",
    note.class,
  )}
/>

{#if is_action_time}
  <CommandLite {focusEditableDiv} bind:text_content {note} {live} />
{/if}
