<script lang="ts">
  import { type Pane } from "../../types";
  import PaneItem from "../pane-item/pane-item.svelte";
  export let panes: Pane[] = [];

  $: noPanes = panes.length === 0;
</script>

<div class="grid grid-cols-10 p-md gap-md">
  {#each panes as pane}
    <PaneItem {pane} />
  {/each}
</div>

{#if noPanes}
  <div>no panes</div>
{/if}
