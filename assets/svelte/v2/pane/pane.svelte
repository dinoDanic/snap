<script lang="ts">
  import { Pane } from "$lib/types";

  export let pane: Pane;
</script>

<div class="min-w-[33.33%] bg-background hover:bg-secondary/10 flex-1 border border-b-transparent border-l-transparent p-sm flex items-center justify-center">
  {pane.name}
</div>
