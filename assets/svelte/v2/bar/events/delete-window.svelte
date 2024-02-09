<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import * as AlertDialog from "$lib/components/ui/alert-dialog";
  import { DeleteIcon, LayoutPanelTopIcon, Trash2Icon } from "lucide-svelte";
  import Button from "$lib/components/ui/button/button.svelte";

  export let runCommand: (eventName: string, args?: object) => void;

  let open = false;

  $: console.log(open);

  const submit = () => {
    runCommand("delete_window");
  };
</script>

<Command.Item
  onSelect={() => {
    open = !open;
  }}
>
  <Trash2Icon class="mr-2 h-4 w-4" />
  Delete window
</Command.Item>

<AlertDialog.Root {open}>
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
