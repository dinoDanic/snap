<script lang="ts">
  import { Live } from "live_svelte";
  import { isStringANumber } from "../helpers/numbers";
  import Item from "./item.svelte";
  import { Button } from "$lib/components/ui/button";
  import { MenuIcon, PlusIcon } from "lucide-svelte";
  import Command from "./command.svelte";
  import { onMount } from "svelte";

  export let sessions: { id: number; name: string }[] = [];
  export let active_session: { id: number; name: string };
  export let live: Live;

  let open = false;

  // const _onkeyDown = (e: KeyboardEvent) => {
  //   const { key } = e;
  //   if (isStringANumber(key)) {
  //     const keyIndex = Number(key) - 1;
  //     const findSession = sessions.at(keyIndex);
  //     if (findSession) {
  //       live.pushEvent("change_session", { session_id: findSession.id });
  //     }
  //     //
  //   } else {
  //     //
  //   }
  // };

  onMount(() => {
    function handleKeydown(e: KeyboardEvent) {
      if (open) return;
      const { key } = e;
      if (isStringANumber(key)) {
        const keyIndex = Number(key) - 1;
        const findSession = sessions.at(keyIndex);
        if (findSession) {
          live.pushEvent("change_session", { session_id: findSession.id });
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
  <div class="flex gap-md flex-1 overflow-scroll">
    {#each sessions as session, index}
      <Item
        {session}
        isActive={active_session.id === session.id}
        index={index + 1}
      />
    {/each}
  </div>
  <button on:click={() => (open = true)} class="flex items-center">
    <MenuIcon class="w-4" />
    <p class="text-sm text-muted-foreground">
      <kbd
        class="pointer-events-none inline-flex h-5 select-none items-center gap-1 rounded border bg-muted px-1.5 font-mono text-[10px] font-medium text-muted-foreground opacity-100"
      >
        <span class="text-xs">⌘</span>K
      </kbd>
    </p>
  </button>
</div>

<Command {open} {live} />
<!-- <svelte:window on:keydown|preventDefault={_onkeyDown} /> -->
