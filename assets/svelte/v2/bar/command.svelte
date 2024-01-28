<script lang="ts">
  import { GridIcon } from "lucide-svelte";
  import * as Command from "$lib/components/ui/command";
  import { onMount } from "svelte";
  import { Live } from "live_svelte";
  import DeleteSession from "./events/delete-session.svelte";
  // import InviteSession from "./events/invite-session.svelte";
  // import ListSessions from "./events/list-sessions.svelte";
  import CreateWindow from "./events/create-window.svelte";
  import DeleteWindow from "./events/delete-window.svelte";
  import CreatePane from "./events/create-pane.svelte";
  import CreateSession from "./events/create-session.svelte";

  export let open = false;
  export let live: Live;

  onMount(() => {
    function handleKeydown(e: KeyboardEvent) {
      if (e.key === "k" && (e.metaKey || e.ctrlKey)) {
        e.preventDefault();
        open = !open;
      }
    }

    document.addEventListener("keydown", handleKeydown);
    return () => {
      document.removeEventListener("keydown", handleKeydown);
    };
  });

  function runCommand(eventName: string, args?: object) {
    live.pushEvent(eventName, args);
    open = false;
  }

  // function createSession() {
  //   runCommand(() => {
  //     live.pushEvent("create_session");
  //   });
  // }
  //
  // function deleteSession() {
  //   runCommand(() => {
  //     live.pushEvent("delete_session");
  //   });
  // }
  //
  // function inviteSession(email: string) {
  //   runCommand(() => {
  //     live.pushEvent("invite_session", { email: email });
  //   });
  // }
  //
  // function listSessions() {
  //   runCommand(() => {
  //     live.pushEvent("list_sessions");
  //   });
  // }
  //
  // function createWindow(window_name: string) {
  //   runCommand(() => {
  //     live.pushEvent("create_window", { window_name });
  //   });
  // }
  //
  // function deleteWindow() {
  //   runCommand(() => {
  //     live.pushEvent("delete_window");
  //   });
  // }
  //
  // function createPane() {
  //   runCommand(() => {
  //     live.pushEvent("create_pane");
  //   });
  // }
</script>

<Command.Dialog bind:open>
  <Command.Input placeholder="Type a command or search..." />
  <Command.List>
    <Command.Empty>No results found.</Command.Empty>
    <Command.Group heading="Pane">
      <!-- <CreatePane {runCommand} /> -->
    </Command.Group>
    <Command.Separator />
    <Command.Group heading="Window">
      <CreateWindow {runCommand} />
      <DeleteWindow {runCommand} />
    </Command.Group>
    <Command.Separator />
    <Command.Group heading="Session">
      <CreateSession {runCommand} />
      <DeleteSession {runCommand} />
      <!-- <InviteSession {live} /> -->
      <!-- <Command.Item onSelect={createSession}> -->
      <!-- <GridIcon class="mr-2 h-4 w-4" /> -->
      <!-- <span>New Session</span> -->
      <!-- </Command.Item> -->
      <!-- <ListSessions {live} /> -->
    </Command.Group>
  </Command.List>
</Command.Dialog>
