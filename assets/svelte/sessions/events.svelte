<script lang="ts">
  import { Live } from "live_svelte";
  import { isStringANumber } from "../helpers/numbers";

  export let sessions: { id: number }[] = [];
  export let live: Live;

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
      // if (!currentSession) return;
      // if (key === "h" || key === "ArrowLeft") {
      //   sessionStore.updateFocus(currentSession.id, "left");
      // } else if (key === "l" || key === "ArrowRight") {
      //   sessionStore.updateFocus(currentSession.id, "right");
      // } else if (key === "k" || key === "ArrowUp") {
      //   sessionStore.updateFocus(currentSession.id, "up");
      // } else if (key === "j" || key === "ArrowDown") {
      //   sessionStore.updateFocus(currentSession.id, "down");
      // } else if (key === "n") {
      //   sessionStore.newPanel(currentSession.id);
      // } else if (key === "x") {
      //   sessionStore.removePanel(currentSession.id);
      // }
    }
  };
</script>

<svelte:window on:keydown|preventDefault={_onkeyDown} />
