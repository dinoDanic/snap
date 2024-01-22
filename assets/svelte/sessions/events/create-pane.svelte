<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import * as AlertDialog from "$lib/components/ui/alert-dialog";
  import { InspectionPanelIcon, LayoutPanelTopIcon } from "lucide-svelte";
  import Button from "$lib/components/ui/button/button.svelte";

  export let createPane: () => void;

  const submit = () => {
    createPane();
  };
</script>

<Command.Item onSelect={submit}>
  <InspectionPanelIcon class="mr-2 h-4 w-4" />
  <span>New Pane</span>
</Command.Item>
