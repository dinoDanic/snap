<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { InspectionPanelIcon } from "lucide-svelte";

  export let createPane: () => void;

  const submit = () => {
    createPane();
  };
</script>

<Command.Item onSelect={submit}>
  <InspectionPanelIcon class="mr-2 h-4 w-4" />
  <span>New Pane</span>
</Command.Item>
