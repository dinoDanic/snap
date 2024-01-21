<script lang="ts">
  import { Live } from "live_svelte";
  import { isStringANumber } from "../helpers/numbers";
  import Item from "./item.svelte";
  import { MenuIcon } from "lucide-svelte";
  import Command from "./command.svelte";
  import { onMount } from "svelte";
  import { Session, Window } from "$lib/types";

  export let windows: Window[] = [];
  export let active_session: Session;
  //
  export let active_window_id: string;
  export let live: Live;

  let open = false;

  console.log(active_window_id);

  onMount(() => {
    function handleKeydown(e: KeyboardEvent) {
      if (open) return;
      const { key } = e;
      if (isStringANumber(key)) {
        const keyIndex = Number(key) - 1;
        const findWindow = windows.at(keyIndex);
        if (findWindow) {
          live.pushEvent("change_window", { window_id: findWindow.id });
        }
        //
      } else {
        //
      }
    }

    document.addEventListener("keydown", handleKeydown);
    return () => {
      document.removeEventListener("keydown", handleKeydown);
    };
  });
</script>

<div class="flex bg-accent">
  <div class="px-md bg-lime-700 text-sm">
    {active_session.name}
  </div>
  <div class="flex gap-md flex-1 overflow-scroll">
    {#each windows as windowItem, index}
      <Item
        {windowItem}
        isActive={active_window_id == windowItem.id}
        index={index + 1}
      />
    {/each}
  </div>
  <button on:click={() => (open = true)} class="flex items-center">
    <MenuIcon class="w-4" />
    <p class="text-sm">
      <kbd
        class="pointer-events-none inline-flex h-5 select-none items-center gap-1 rounded border bg-muted px-1.5 font-mono text-[10px] font-medium opacity-100"
      >
        <span class="text-xs">⌘</span>K
      </kbd>
    </p>
  </button>
</div>

<Command {open} {live} />
<!-- <svelte:window on:keydown|preventDefault={_onkeyDown} /> -->
