<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { text_colors } from "../colors";
  import { cn } from "$lib/utils";
  import { Note } from "$lib/types";
  import { Live } from "live_svelte";
  import { note_settings } from "$lib/v2/note/settings";

  export let live: Live;
  export let note: Note;
  export let text_content: string;
  export let focusEditableDiv: () => void;

  const on_select = (value: string) => {
    const findColor = text_colors.find((c) => c.key === value);
    if (!findColor) throw Error("Did not found color");

    const remove_text_color = note.class?.filter(
      (c) => c.includes("text-") !== true,
    );

    const oldClasses = remove_text_color || [];

    const new_note = {
      ...note,
      class: [...oldClasses, findColor.value],
    };

    live.pushEvent("update_note", new_note);
    text_content = note_settings.remove_action_time_trigger(text_content);
    focusEditableDiv();
  };
</script>

<Command.Group heading="Color">
  {#each text_colors as color}
    <Command.Item value={color.key} onSelect={on_select}>
      <p class={cn(color.value, "mr-sm")}>A</p>
      {color.label}
    </Command.Item>
  {/each}
</Command.Group>
