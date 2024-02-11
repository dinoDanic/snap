<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { onMount } from "svelte";
  import { Live } from "live_svelte";
  import DeleteSession from "./events/delete-session.svelte";
  import InviteSession from "./events/invite-session.svelte";
  import Logout from "./events/logout.svelte";
  import CreateWindow from "./events/create-window.svelte";
  import DeleteWindow from "./events/delete-window.svelte";
  import CreateSession from "./events/create-session.svelte";

  export let command_open = false;
  export let live: Live;

  $: open = command_open;

  onMount(() => {
    function handleKeydown(e: KeyboardEvent) {
      if (e.key === "m" && (e.metaKey || e.ctrlKey)) {
        e.preventDefault();
        live.pushEvent("command_open", { state: !command_open });
      }
    }

    document.addEventListener("keydown", handleKeydown);
    return () => {
      document.removeEventListener("keydown", handleKeydown);
    };
  });

  function setCommand(state: boolean) {
    live.pushEvent("command_open", { state: state });
  }

  function runCommand(eventName: string, args?: object) {
    live.pushEvent(eventName, args);
    setCommand(false);
  }
</script>

<Command.Dialog bind:open onOpenChange={(state) => setCommand(state)}>
  <Command.Input placeholder="Type a command or search..." />
  <Command.List>
    <Command.Empty>No results found.</Command.Empty>
    <DeleteWindow {runCommand} />
    <CreateWindow {runCommand} />
    <CreateSession {runCommand} />
    <DeleteSession {runCommand} />
    <InviteSession {runCommand} />
    <Logout {runCommand} />
  </Command.List>
</Command.Dialog>
