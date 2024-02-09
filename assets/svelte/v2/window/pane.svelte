<script lang="ts">
  import { Pane } from "$lib/types";
  import { Live } from "live_svelte";

  export let pane: Pane;
  export let live: Live;
  let paneNotes = pane.notes?.length || 0;
</script>

<!-- svelte-ignore a11y-autofocus -->
<button
  class="focus:underline bg-background hover:bg-secondary/20 hover:underline"
  autofocus
  on:click={() => live.pushEvent("go_to_pane", { pane_id: pane.id })}
>
  {pane.id}.
  {pane.name}
  {#if paneNotes > 0}
    <span class="text-xs text-secondary">({paneNotes})</span>
  {/if}
</button>
