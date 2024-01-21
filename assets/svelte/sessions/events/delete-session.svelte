<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import * as AlertDialog from "$lib/components/ui/alert-dialog";
  import { TrashIcon } from "lucide-svelte";
  import Button from "$lib/components/ui/button/button.svelte";
  export let deleteSession: () => void;
</script>

<AlertDialog.Root>
  <AlertDialog.Trigger class="w-full">
    <Command.Item>
      <TrashIcon class="mr-2 h-4 w-4" />
      <span>Delete</span>
    </Command.Item>
  </AlertDialog.Trigger>
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
      <Button on:click={deleteSession}>Continue</Button>
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
