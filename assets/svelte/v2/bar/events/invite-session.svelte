<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import * as AlertDialog from "$lib/components/ui/alert-dialog";
  import { UserPlusIcon } from "lucide-svelte";
  import Button from "$lib/components/ui/button/button.svelte";
  import { Input } from "$lib/components/ui/input";

  export let runCommand: (eventName: string, args?: object) => void;

  let value: string;
  let open: boolean = false;

  const submit = () => {
    runCommand("invite_session", { email: value });
  };
</script>

<Command.Item onSelect={() => (open = !open)}>
  <UserPlusIcon class="mr-2 h-4 w-4" />
  <span>Invite To Session</span>
</Command.Item>

<AlertDialog.Root {open}>
  <AlertDialog.Content>
    <form on:submit|preventDefault={submit} class="space-y-lg">
      <AlertDialog.Header>
        <AlertDialog.Title>Invite user</AlertDialog.Title>
        <AlertDialog.Description>Provide email address</AlertDialog.Description>
        <Input bind:value />
      </AlertDialog.Header>
      <AlertDialog.Footer>
        <AlertDialog.Cancel>Cancel</AlertDialog.Cancel>
        <Button type="submit">Invite</Button>
      </AlertDialog.Footer>
    </form>
  </AlertDialog.Content>
</AlertDialog.Root>
