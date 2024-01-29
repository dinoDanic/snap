<script lang="ts">
  import { marked } from "marked";
  import { cn } from "$lib/utils";
  import { Note } from "$lib/types";
  import { Live } from "live_svelte";

  let inputRef: HTMLInputElement;
  let divRef: HTMLDivElement;
  let isEditing = false;

  export let live: Live;

  export let note: Note;

  let value = note.note || "";

  function handleFocus() {
    isEditing = true;
    // Timeout to ensure the input is rendered before focusing
    setTimeout(() => {
      // if (divRef) divRef.focus();
      if (inputRef) inputRef.focus();
    }, 0);
  }

  $: htmlContent = marked(value);
  $: isH1 = value.startsWith("# ");
  $: isH2 = value.startsWith("## ");
  $: isH3 = value.startsWith("### ");
  $: isH4 = value.startsWith("#### ");

  const _onkeyDown = (e: KeyboardEvent) => {
    const { key } = e;
  };

  const onBlur = () => {
    isEditing = false;
    console.log('value', value, note.note)
    if (value !== note.note || "") {
      live.pushEvent("update_note", { ...note, note: value });
    }
  };

  const shareClass = "min-h-[40px] flex items-center px-md py-sm rounded";
</script>

{#if isEditing}
  <input
    bind:this={inputRef}
    bind:value
    class={cn(
      "bg-secondary/50 w-full focus:border-none focus:outline-none  overflow-y-hidden resize-none",
      shareClass,
      isH1 && "text-4xl",
      isH2 && "text-3xl",
      isH3 && "text-2xl",
      isH4 && "text-xl",
    )}
    on:blur={onBlur}
  />
  <!-- <div -->
  <!--   bind:this={divRef} -->
  <!--   bind:textContent={value} -->
  <!--   contenteditable="true" -->
  <!--   on:blur={() => (isEditing = false)} -->
  <!--   class={cn( -->
  <!--     "bg-primary/20 w-full focus:border-none focus:outline-none  overflow-y-hidden resize-none", -->
  <!--     // shareClass, -->
  <!--     isH1 && "text-4xl", -->
  <!--     isH2 && "text-3xl", -->
  <!--     isH3 && "text-2xl", -->
  <!--     isH4 && "text-xl", -->
  <!--   )} -->
  <!-- > -->
  <!--   {value} -->
  <!-- </div> -->
{:else}
  <!-- svelte-ignore a11y-click-events-have-key-events -->
  <!-- svelte-ignore a11y-no-noninteractive-tabindex -->
  <!-- svelte-ignore a11y-no-static-element-interactions -->
  <div
    class={cn("text-white hover:bg-secondary/30", shareClass)}
    tabindex={0}
    on:click={handleFocus}
    on:focus={handleFocus}
    aria-label="Edit content"
  >
    {@html htmlContent}
  </div>
{/if}

<!-- <svelte:window on:keydown|preventDefault={_onkeyDown} /> -->
