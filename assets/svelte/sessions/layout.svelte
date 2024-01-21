<script lang="ts">
  import { Live } from "live_svelte";
  import { isStringANumber } from "../helpers/numbers";
  import Item from "./item.svelte";
  import { Button } from "$lib/components/ui/button";
  import { PlusIcon } from "lucide-svelte";

  export let sessions: { id: number; name: string }[] = [];
  export let active_session: { id: number; name: string };
  export let live: Live;

  const create_new_session = () => {
    live.pushEvent("create_session");
  };

  const _onkeyDown = (e: KeyboardEvent) => {
    const { key } = e;
    if (isStringANumber(key)) {
      const keyIndex = Number(key) - 1;
      const findSession = sessions.at(keyIndex);
      if (findSession) {
        live.pushEvent("change_session", { session_id: findSession.id });
      }
      //
    } else {
      //
    }
  };
</script>

<div class="flex gap-md">
  {#each sessions as session, index}
    <Item
      {session}
      isActive={active_session.id === session.id}
      index={index + 1}
    />
  {/each}
  <p>|</p>
  <button on:click={create_new_session}>
    <PlusIcon class="w-4" />
  </button>
</div>

<svelte:window on:keydown|preventDefault={_onkeyDown} />
