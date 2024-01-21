<script lang="ts">
  import { cn } from "$lib/utils";

  export let className: string = undefined;
  export let title: string = undefined;
  export let description: string = undefined;
</script>

<div
  class={cn(
    "rounded-md p-md border bg-card text-card-foreground shadow-sm space-y-md w-full",
    className,
  )}
>
  {#if title || description}
    <div class="space-y-xs">
      {#if title}
        <h4>{title}</h4>
      {/if}
      {#if description}
        <p class="text-muted-foreground">{description}</p>
      {/if}
    </div>
  {/if}
  <div>
    <slot />
  </div>
</div>
