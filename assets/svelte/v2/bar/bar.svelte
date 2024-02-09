<script lang="ts">
  import { Live } from "live_svelte";
  import Item from "./item.svelte";
  import Badge from "../../components/ui/badge/badge.svelte";
  import { ArrowRightIcon, CommandIcon } from "lucide-svelte";
  import Command from "./command.svelte";
  import { Pane, Session, Window } from "$lib/types";

  export let win: Window;
  export let session: Session;
  export let live: Live;
  export let pane: Pane;

  export let command_open: boolean = false;

  const change_window = (index: number) => {
    const findWindow = session.windows.at(index);
    if (findWindow) {
      live.pushEvent("change_window", { window_id: findWindow.id });
    }
  };
</script>

<div class="flex p-sm gap-sm">
  <Badge class="px-md" variant="secondary">
    {session.name}
  </Badge>
  <ArrowRightIcon class="w-4 text-muted-foreground" />
  <div class="flex gap-0 flex-1 overflow-scroll">
    {#each session.windows as sessionWindow, index}
      <Item
        {pane}
        windowItem={sessionWindow}
        isActive={Number(win.id) === sessionWindow.id}
        {index}
        {change_window}
      />
    {/each}
  </div>
  <button class="flex items-center">
    <Badge variant="secondary">
      <CommandIcon class="w-2.5 h-2.5 mr-xs" />
      M
    </Badge>
  </button>
</div>

<Command {command_open} {live} />
