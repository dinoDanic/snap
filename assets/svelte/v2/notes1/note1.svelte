<script lang="ts">
  import { marked } from "marked";
  import { cn } from "$lib/utils";
  import { Note } from "$lib/types";
  import { Live } from "live_svelte";
  import {
    prepareContent,
    calculateImportanceLevel,
  } from "./fns/prepare-content";
  import ImportanceLevel from "./components/importance-level.svelte";

  let inputRef: HTMLInputElement;
  let isEditing = false;

  export let live: Live;
  export let note: Note;
  export let focus_index: number;
  export let index: number;

  let value = note.note || "";

  function handleFocus() {
    isEditing = true;
    focus_index = index;
    setTimeout(() => {
      if (inputRef) inputRef.focus();
    }, 0);
  }

  function handleVimFocus(focus_index: number) {
    const isActive = index === focus_index;
    if (isActive) {
      isEditing = true;
      setTimeout(() => {
        if (inputRef) inputRef.focus();
      }, 0);
    }
  }

  $: handleVimFocus(focus_index);

  $: htmlContent = marked(prepareContent(value));

  $: isH1 = value.startsWith("# ");
  $: isH2 = value.startsWith("## ");
  $: isH3 = value.startsWith("### ");
  $: isH4 = value.startsWith("#### ");

  $: importanceLevel = calculateImportanceLevel(value);

  let item =
    "bg-red-200 bg-red-400 text-red-200 text-primary hover:opacity-50 hover:text-red-200";

  $: cssValue = value.match(/:"([^"]*)"/)?.[1];

  const onBlur = () => {
    isEditing = false;
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
{:else}
  <!-- svelte-ignore a11y-click-events-have-key-events -->
  <!-- svelte-ignore a11y-no-noninteractive-tabindex -->
  <!-- svelte-ignore a11y-no-static-element-interactions -->
  <div
    class={cn("hover:bg-secondary/30", shareClass, cssValue)}
    tabindex={0}
    on:click={handleFocus}
    on:focus={handleFocus}
    aria-label="Edit content"
  >
    <ImportanceLevel {importanceLevel} />
    {@html htmlContent}
  </div>
{/if}
