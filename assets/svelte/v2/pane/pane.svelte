<script lang="ts">
  import { Pane } from "$lib/types";
  import { Live } from "live_svelte";
  import Note from "../note/note.svelte";
  // import { onMount } from "svelte";
  // import { vimKeyEvents } from "../../vim-key-events";

  export let pane: Pane;
  export let live: Live;
  // export let command_open: boolean = false;

  $: focus_index = 0;

  // const notes_length = pane.notes.length;
  //
  // const handleKeydown = (event: KeyboardEvent) => {
  //   if (command_open) return;
  //
  //   const directoion = vimKeyEvents.direction(event);
  //
  //   if (directoion === "down") {
  //     event.preventDefault();
  //     if (focus_index < notes_length - 1) {
  //       focus_index += 1;
  //     }
  //   } else if (directoion === "up") {
  //     event.preventDefault();
  //     if (focus_index !== 0) {
  //       focus_index -= 1;
  //     }
  //   }
  //   if (event.ctrlKey && event.key === "1") {
  //     event.preventDefault();
  //   }
  // };
  //
  // onMount(() => {
  //   document.addEventListener("keydown", handleKeydown);
  //   return () => {
  //     document.removeEventListener("keydown", handleKeydown);
  //   };
  // });
</script>

<div class="p-md">
  {#each pane.notes as note, index}
    <Note {index} {focus_index} {note} {live} />
  {/each}
</div>
