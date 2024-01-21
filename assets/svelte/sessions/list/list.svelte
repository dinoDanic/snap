<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import type { Session } from "../../types";
  import { Live } from "live_svelte";
  import ItemList from "./item-list.svelte";

  export let live: Live;

  export let private_sessions: Session[];
  export let public_sessions: Session[];

 console.log(public_sessions)

  const onSelect = (id: string) => {
    live.pushEvent("redirect", { session_id: id });
  };
</script>

<div class="flex items-center justify-center h-[100vh]">
  <div class="max-w-[600px] w-full border rounded-md">
    <Command.Root>
      <Command.Input autofocus placeholder="Search sessions" />
      <Command.List>
        <Command.Empty>No results found.</Command.Empty>
        <ItemList sessions={private_sessions} {onSelect} heading="Private" />
        <Command.Separator />
        <ItemList sessions={public_sessions} {onSelect} heading="Public" />
      </Command.List>
    </Command.Root>
  </div>
</div>
