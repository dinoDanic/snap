<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import { DotIcon } from "lucide-svelte";
  import type { Window } from "../../types";

  export let isActive: boolean = false;
  export let windowItem: Window;
  export let index: number = 0;
</script>

{#if index !== 1}
  <DotIcon class="text-muted-foreground" />
{/if}
<Badge variant={isActive ? "default" : "secondary"}>
  <span class="mr-xs">{index}.</span>
  <span class="truncate whitespace-nowrap max-w-[150px]">{windowItem.name}</span
  >
</Badge>
