<script lang="ts">
  import { cn } from "$lib/utils";
  import type { Window } from "../types";

  export let isActive: boolean = false;
  export let windowItem: Window;
  export let index: number = 0;
</script>

<div class="flex items-center justify-center gap-2">
  <div
    class={cn(
      "flex w-8 items-center justify-center bg-accent text-primary-foreground",
      isActive && "bg-primary",
    )}
  >
    <p class="text-sm">{index}</p>
  </div>
  <div class="whitespace-nowrap">{windowItem?.name}</div>
</div>
