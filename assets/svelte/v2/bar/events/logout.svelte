<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { LogOutIcon } from "lucide-svelte";

  export let runCommand: (eventName: string, args?: object) => void;

  const submit = () => {
    runCommand("log_out");
  };
</script>

<Command.Item onSelect={submit}>
  <LogOutIcon class="mr-2 h-4 w-4" />
  <span>Logout</span>
</Command.Item>
