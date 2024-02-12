<script lang="ts">
  import { Pane } from "$lib/types";
  import { Live } from "live_svelte";
  import Note from "../note/note.svelte";

  export let pane: Pane;
  export let live: Live;
</script>

<div class="p-md">
  {#each pane.notes as note}
    <Note {note} {live} />
  {/each}
</div>
