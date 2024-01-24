<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { AppWindowIcon, Grid2x2Icon } from "lucide-svelte";
  import type { Session } from "../../../types";

  export let sessions: Session[];

  export let onSelect: (id: string) => void;
  export let heading: string;
</script>

{#if sessions.length > 0}
  <Command.Group heading={heading}>
    {#each sessions as session}
      <Command.Item onSelect={() => onSelect(session.id)}>
        <AppWindowIcon class="m-2 h-4 w-4" />
        <span>{session.name}</span>
      </Command.Item>
    {/each}
  </Command.Group>
{/if}
