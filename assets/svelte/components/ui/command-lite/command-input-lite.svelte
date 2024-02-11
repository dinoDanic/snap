<script lang="ts">
  import { Command as CommandPrimitive } from "cmdk-sv";
  import { Search } from "lucide-svelte";
  import { cn } from "$lib/utils";

  type $$Props = CommandPrimitive.InputProps;

  let className: string | undefined | null = undefined;
  export { className as class };
  export let value: string = "";
</script>

<CommandPrimitive.Input
  class="opacity-0 pointer-events-none h-0 max-h-0 absolute z-[-100] overflow-hidden"
  {...$$restProps}
  bind:value
/>
