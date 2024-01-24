<script lang="ts">
  import Card from "$lib/components/ui/card/card.svelte";
  import { type Pane } from "../../types";
  export let pane: Pane;
</script>

<button class="focus:outline-primary focus:border-none focus:ring-2 rounded-md focus:ring-offset-primary">
  <Card className="bg-secondary">
    <p class="text-left">{pane.name}</p>
  </Card>
</button>
