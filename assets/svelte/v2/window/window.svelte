<script lang="ts">
  import { Window } from "$lib/types";
  import Pane2 from "../pane/pane2.svelte";

  export let win: Window;
</script>

{#each win.panes as pane}
  <Pane2 {pane} />
{/each}
