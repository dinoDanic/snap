<script lang="ts">
  import { Pane } from "$lib/types";
  import Note from "../notes/note.svelte";

  export let pane: Pane;
</script>

<p>{pane.name}</p>

{#each pane.notes as note}
  <Note />
  <Note />
  <Note />
  <Note />
  <Note />
  <Note />
  <Note />
{/each}
