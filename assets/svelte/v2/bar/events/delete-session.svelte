<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import * as AlertDialog from "$lib/components/ui/alert-dialog";
  import { TrashIcon } from "lucide-svelte";
  import Button from "$lib/components/ui/button/button.svelte";

  export let runCommand: (eventName: string, args?: object) => void;

  export let open: boolean = false;

  const submit = () => {
    runCommand("delete_session");
  };
</script>

<Command.Item onSelect={() => (open = !open)}>
  <TrashIcon class="mr-2 h-4 w-4" />
  <span>Delete Session</span>
</Command.Item>

<AlertDialog.Root {open}>
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>Are you absolutely sure?</AlertDialog.Title>
      <AlertDialog.Description>
        This action cannot be undone. This will permanently delete your and
        users assosicated with this session
      </AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      <AlertDialog.Cancel>Cancel</AlertDialog.Cancel>
      <Button on:click={submit}>Continue</Button>
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
