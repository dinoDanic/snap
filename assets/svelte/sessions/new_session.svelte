<script lang="ts">
  import Button from "$lib/components/ui/button/button.svelte";
  import Card from "$lib/components/ui/card/card.svelte";
  import Input from "$lib/components/ui/input/input.svelte";
  import { Live } from "live_svelte";

  export let live: Live;
  let value: string = "";

  const create = () => {
    if (value !== "") {
      live.pushEvent("create", { name: value });
      value = "";
    }
  };
</script>

<div class="flex items-center justify-center h-[100vh]">
  <Card
    title="Create a session"
    className="max-w-[400px]"
    description="persistent and independent workspace that can contain multiple windows and panes."
  >
    <form on:submit|preventDefault={create}>
      <div class="space-y-md">
        <Input bind:value autofocus />
        <Button on:click={create} class="w-full">Create</Button>
        <slot />
      </div>
    </form>
  </Card>
</div>
