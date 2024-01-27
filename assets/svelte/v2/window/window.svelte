<script lang="ts">
  import { Window } from "$lib/types";
  import Pane from "../pane/pane.svelte";

  export let win: Window;
</script>

<div class="flex flex-wrap h-full">
  {#each win.panes as pane}
    <Pane {pane} />
  {/each}
</div>
