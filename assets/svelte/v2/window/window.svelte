<script lang="ts">
  import { Window } from "$lib/types";
  import { Live } from "live_svelte";
  import Pane from "../pane/pane.svelte";

  export let win: Window;
  export let live: Live;
</script>

<div class="flex flex-wrap h-full">
  {#each win.panes as pane}
    <Pane {pane} {live} />
  {/each}
</div>
