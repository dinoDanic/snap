<script lang="ts">
  import { Pane } from "$lib/types";
  import { Live } from "live_svelte";

  export let pane: Pane;
  export let live: Live;
</script>

<button
  class="min-w-[33.33%] bg-background hover:bg-secondary/20 flex-1 border border-b-transparent border-l-transparent p-sm flex items-center justify-center"
  on:click={() => live.pushEvent("go_to_pane", { pane_id: pane.id })}
>
  {pane.name}
</button>
