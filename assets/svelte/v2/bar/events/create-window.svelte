<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import * as AlertDialog from "$lib/components/ui/alert-dialog";
  import { LayoutPanelTopIcon } from "lucide-svelte";
  import Button from "$lib/components/ui/button/button.svelte";
  import { Input } from "$lib/components/ui/input";

  export let runCommand: (eventName: string, args?: object) => void;

  let value: string;
  let open: boolean = false;

  const submit = () => {
    if (value === "" || !value) return;
    runCommand("create_window", { window_name: value });
  };
</script>

<Command.Item onSelect={() => open = !open}>
  <LayoutPanelTopIcon class="mr-2 h-4 w-4" />
  Create Window
</Command.Item>

<AlertDialog.Root {open}>
  <AlertDialog.Content>
    <form on:submit|preventDefault={submit} class="space-y-lg">
      <AlertDialog.Header>
        <AlertDialog.Title>Create window</AlertDialog.Title>
        <AlertDialog.Description>Provide window name</AlertDialog.Description>
        <Input bind:value />
      </AlertDialog.Header>
      <AlertDialog.Footer>
        <AlertDialog.Cancel>Cancel</AlertDialog.Cancel>
        <Button type="submit">Create</Button>
      </AlertDialog.Footer>
    </form>
  </AlertDialog.Content>
</AlertDialog.Root>
