<script lang="ts">
  import { Window } from "$lib/types";
  import { Live } from "live_svelte";
  import Pane from "./pane.svelte";

  export let win: Window;
  export let live: Live;
  $: havePanes = win.panes.length > 0;
</script>

<div class="flex flex-wrap h-full">
  {#if havePanes}
    {#each win.panes as pane}
      <Pane {pane} {live} />
    {/each}
  {:else}
    <p>no panes</p>
  {/if}
</div>
