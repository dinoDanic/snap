<script lang="ts">
  import { GridIcon } from "lucide-svelte";
  import * as Command from "$lib/components/ui/command";
  import { onMount } from "svelte";
  import { Live } from "live_svelte";
  import DeleteSession from "./events/delete-session.svelte";
  import InviteSession from "./events/invite-session.svelte";

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

  const onSelect = () => {
    console.log("on select");
  };

  function runCommand(cmd: () => void) {
    cmd();
    open = false;
  }

  function createSession() {
    runCommand(() => {
      live.pushEvent("create_session");
    });
  }
  function deleteSession() {
    runCommand(() => {
      live.pushEvent("delete_session");
    });
  }
  function inviteSession(email: string) {
    runCommand(() => {
      live.pushEvent("invite_session", { email: email });
    });
  }
</script>

<Command.Dialog bind:open on:select={() => console.log("kita")}>
  <Command.Input
    class="border-none outline-none focus:outline-none focus:ring-transparent focus:shadow-none focus:border-none"
    placeholder="Type a command or search..."
  />
  <Command.List>
    <Command.Empty>No results found.</Command.Empty>
    <Command.Group heading="Current Session">
      <DeleteSession {deleteSession} />
      <InviteSession {inviteSession} />
    </Command.Group>
    <!-- <Command.Separator /> -->
    <Command.Group heading="Session">
      <Command.Item onSelect={createSession}>
        <GridIcon class="mr-2 h-4 w-4" />
        <span>New</span>
      </Command.Item>
    </Command.Group>
  </Command.List>
</Command.Dialog>
