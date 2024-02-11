<script lang="ts">
  import { AlertCircleIcon } from "lucide-svelte";

  export let importanceLevel: number = 0;

  $: iconsToRender = Array(importanceLevel).fill(null);
</script>

{#if importanceLevel > 0}
  <div class="pr-md flex gap-xs">
    {#each iconsToRender as _, index (index)}
      <AlertCircleIcon class="w-5 h-5" />
    {/each}
  </div>
{/if}
