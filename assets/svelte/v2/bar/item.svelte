<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import { DotIcon } from "lucide-svelte";
  import type { Pane, Window } from "../../types";
  import { cn } from "$lib/utils";

  export let change_window: (index: number) => void;

  export let isActive: boolean = false;
  export let windowItem: Window;
  export let pane: Pane;
  export let index: number = 0;
</script>

{#if index !== 0}
  <DotIcon class="text-muted-foreground" />
{/if}
<button on:click={() => change_window(index)}>
  <Badge
    variant={isActive ? "default" : "secondary"}
    class={cn("z-10 relative", !isActive && "opacity-50")}
  >
    <span class="mr-xs">{index + 1}.</span>
    <span class="truncate whitespace-nowrap max-w-[150px]"
      >{windowItem.name}</span
    >
  </Badge>
  {#if pane.id && isActive}
    <Badge variant="secondary" class="-ml-sm text-muted-foreground relative">
      {pane.name}
    </Badge>
  {/if}
</button>
