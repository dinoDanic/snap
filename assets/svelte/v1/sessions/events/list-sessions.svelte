<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { ListIcon } from "lucide-svelte";

  export let listSessions: () => void;

  const submit = () => {
    listSessions();
  };
</script>

<Command.Item onSelect={submit}>
  <ListIcon class="mr-2 h-4 w-4" />
  <span>My Sessions</span>
</Command.Item>
