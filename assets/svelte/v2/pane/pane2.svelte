<script lang="ts">
  import { marked } from "marked";
  import { cn } from "$lib/utils";
  import { Pane } from "$lib/types";

  let markdownStore = "";
  let inputRef: HTMLInputElement; // Reference for the input element
  let isEditing = false;

  export let pane: Pane;

  function handleFocus() {
    isEditing = true;
    // Timeout to ensure the input is rendered before focusing
    setTimeout(() => {
      if (inputRef) inputRef.focus();
    }, 0);
  }

  $: htmlContent = marked(markdownStore);
  $: isH1 = markdownStore.startsWith("# ");
  $: isH2 = markdownStore.startsWith("## ");
  $: isH3 = markdownStore.startsWith("### ");
  $: isH4 = markdownStore.startsWith("#### ");

  const _onkeyDown = (e: KeyboardEvent) => {
    const { key } = e;
    console.log(key);
  };
</script>

{#if isEditing}
  <input
    bind:this={inputRef}
    bind:value={markdownStore}
    class={cn(
      "bg-black w-full focus:border-none focus:outline-none min-h-[40px] flex items-center",
      isH1 && "text-4xl",
      isH2 && "text-3xl",
      isH3 && "text-2xl",
      isH4 && "text-xl",
    )}
    on:blur={() => (isEditing = false)}
  />
{:else}
  <!-- svelte-ignore a11y-click-events-have-key-events -->
  <!-- svelte-ignore a11y-no-noninteractive-tabindex -->
  <!-- svelte-ignore a11y-no-static-element-interactions -->
  <div
    class="text-white hover:bg-primary/10 min-h-[40px] flex items-center"
    tabindex={0}
    on:click={handleFocus}
    on:focus={handleFocus}
    aria-label="Edit content"
  >
    {@html htmlContent}
  </div>
{/if}

<!-- <svelte:window on:keydown|preventDefault={_onkeyDown} /> -->
