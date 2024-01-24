<script lang="ts">
  import { Live } from "live_svelte";
  import { isStringANumber } from "../../helpers/numbers";
  import Item from "./item.svelte";
  import Badge from "../../components/ui/badge/badge.svelte";
  import { ArrowRightIcon, CommandIcon } from "lucide-svelte";
  import Command from "./command.svelte";
  import { onMount } from "svelte";
  import { Session, Window } from "$lib/types";

  export let windows: Window[] = [];
  export let active_session: Session;
  export let active_window_id: string;
  export let live: Live;

  let open = false;

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

<div class="flex h-[40px] p-sm gap-sm">
  <Badge class="px-md" variant="secondary">
    {active_session.name}
  </Badge>
  <ArrowRightIcon class="w-4 text-muted-foreground" />
  <div class="flex gap-0 flex-1 overflow-scroll">
    {#each windows as windowItem, index}
      <Item
        {windowItem}
        isActive={Number(active_window_id) === windowItem.id}
        index={index + 1}
      />
    {/each}
  </div>
  <button on:click={() => (open = true)} class="flex items-center">
    <Badge>
      <CommandIcon class="w-2.5 h-2.5 mr-xs" />
      K
    </Badge>
  </button>
</div>

<Command {open} {live} />
<!-- <svelte:window on:keydown|preventDefault={_onkeyDown} /> -->
