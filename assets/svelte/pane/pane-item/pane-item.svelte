<script lang="ts">
  import Card from "$lib/components/ui/card/card.svelte";
  import { type Pane } from "../../types";
  export let pane: Pane;
</script>

<button class="focus:outline-primary focus:border-none focus:ring-2 rounded-md focus:ring-offset-primary">
  <Card>
    <!-- <input -->
    <!--   placeholder="Untitled" -->
    <!--   value={pane.name} -->
    <!--   class="bg-transparent text-md outline-none" -->
    <!-- /> -->
    <p class="text-left">{pane.name}</p>
  </Card>
</button>
