<script lang="ts">
  import { Live } from "live_svelte";
  // import { isStringANumber } from "../../helpers/numbers";
  import Item from "./item.svelte";
  import Badge from "../../components/ui/badge/badge.svelte";
  import { ArrowRightIcon, CommandIcon } from "lucide-svelte";
  import Command from "./command.svelte";
  // import { onMount } from "svelte";
  import { Session, Window } from "$lib/types";

  export let win: Window;
  export let session: Session;
  export let live: Live;

  // $: console.log(session);

  let open = false;

  const change_window = (index: number) => {
    const findWindow = session.windows.at(index);
    if (findWindow) {
      live.pushEvent("change_window", { window_id: findWindow.id });
    }
  };

  // onMount(() => {
  //   function handleKeydown(e: KeyboardEvent) {
  //     if (open) return;
  //     const { key } = e;
  //     if (isStringANumber(key)) {
  //       const keyIndex = Number(key) - 1;
  //       const findWindow = session.windows.at(keyIndex);
  //       if (findWindow) {
  //         console.log(findWindow)
  //         live.pushEvent("change_window", { window_id: findWindow.id });
  //       }
  //       //
  //     } else {
  //       //
  //     }
  //   }
  //
  //   document.addEventListener("keydown", handleKeydown);
  //   return () => {
  //     document.removeEventListener("keydown", handleKeydown);
  //   };
  // });
</script>

<div class="flex h-[40px] p-sm gap-sm">
  <Badge class="px-md" variant="secondary">
    {session.name}
  </Badge>
  <ArrowRightIcon class="w-4 text-muted-foreground" />
  <div class="flex gap-0 flex-1 overflow-scroll">
    {#each session.windows as sessionWindow, index}
        <Item
          windowItem={sessionWindow}
          isActive={Number(win.id) === sessionWindow.id}
          index={index}
          {change_window}
        />
    {/each}
  </div>
  <button
    on:click={() => {
      // open = true;
    }}
    class="flex items-center"
  >
    <Badge>
      <CommandIcon class="w-2.5 h-2.5 mr-xs" />
      K
    </Badge>
  </button>
</div>

<Command {open} {live} />
<!-- <svelte:window on:keydown|preventDefault={_onkeyDown} /> -->
