<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { Note } from "$lib/types";
  import { Live } from "live_svelte";
  import { onMount } from "svelte";
  import { note_settings } from "$lib/v2/note/settings";
  import DynamicGroup from "./groups/dynamic-group.svelte";
  import { css_groups } from "./css";

  export let live: Live;
  export let note: Note;
  export let text_content: string;
  export let focusEditableDiv: () => void;

  onMount(() => {
    function handleKeydown(e: KeyboardEvent) {
      if (e.key === "Escape") {
        e.preventDefault();
        text_content = note_settings.remove_action_time_trigger(text_content);
        focusEditableDiv();
      }
    }
    document.addEventListener("keydown", handleKeydown);
    return () => {
      document.removeEventListener("keydown", handleKeydown);
    };
  });
</script>

<div class="absolute">
  <Command.Root class="border">
    <Command.Input autofocus placeholder="example: color blue" />
    <Command.List>
      <Command.Empty>No results found.</Command.Empty>
      {#each css_groups as css_group}
        <DynamicGroup
          bind:text_content
          {focusEditableDiv}
          {css_group}
          {note}
          {live}
        />
      {/each}
      <Command.Separator />
    </Command.List>
  </Command.Root>
</div>
