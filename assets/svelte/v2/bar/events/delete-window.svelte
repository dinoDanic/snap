<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import * as AlertDialog from "$lib/components/ui/alert-dialog";
  import { LayoutPanelTopIcon } from "lucide-svelte";
  import Button from "$lib/components/ui/button/button.svelte";

  export let deleteWindow: () => void;

  const submit = () => {
    deleteWindow();
  };
</script>

<AlertDialog.Root>
  <AlertDialog.Trigger class="w-full">
    <Command.Item>
      <LayoutPanelTopIcon class="mr-2 h-4 w-4" />
      <span>Delete Window</span>
    </Command.Item>
  </AlertDialog.Trigger>
  <AlertDialog.Content>
    <form on:submit|preventDefault={submit} class="space-y-lg">
      <AlertDialog.Header>
        <AlertDialog.Title>Delete window</AlertDialog.Title>
        <AlertDialog.Description
          >Are you sure, this can not be undone</AlertDialog.Description
        >
      </AlertDialog.Header>
      <AlertDialog.Footer>
        <AlertDialog.Cancel>Cancel</AlertDialog.Cancel>
        <Button type="submit">Delete</Button>
      </AlertDialog.Footer>
    </form>
  </AlertDialog.Content>
</AlertDialog.Root>
