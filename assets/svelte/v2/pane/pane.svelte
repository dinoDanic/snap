<script lang="ts">
  let content = "title";

  let className = "";

  $: {
    if (content.startsWith("###")) {
      className = "text-xl";
    } else if (content.startsWith("##")) {
      className = "text-2xl";
    } else if (content.startsWith("#")) {
      className = "text-3xl";
    } else {
      className = "";
    }
  }

  const on_input = (
    e: Event & {
      currentTarget: EventTarget & HTMLDivElement;
    },
  ) => {
    //@ts-ignore
    if (e.data === null) {
      // 
    }
  };
</script>

<!-- svelte-ignore a11y-no-static-element-interactions -->
<!-- svelte-ignore a11y-no-noninteractive-tabindex -->
<div
  contenteditable="true"
  on:input={(e) => on_input(e)}
  tabindex={0}
  bind:innerHTML={content}
  class={className}
/>
j
