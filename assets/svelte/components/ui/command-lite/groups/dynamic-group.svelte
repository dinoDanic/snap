<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { cn } from "$lib/utils";
  import { Note } from "$lib/types";
  import { Live } from "live_svelte";
  import { type CssDefinition } from "../css";
  import { note_settings } from "$lib/v2/note/settings";

  export let live: Live;
  export let note: Note;
  export let text_content: string;
  export let focusEditableDiv: () => void;

  export let css_definitions: CssDefinition[];
  export let heading: string;
  export let decorator: boolean = false;

  const on_select = (value: string) => {
    const currecnt_css_definition = css_definitions.find(
      (c) => c.key === value,
    );
    if (!currecnt_css_definition) throw Error("Did not found css definition");

    const remove_old_css_definition = note.class?.filter(() =>
      css_definitions.some((ts) => ts.value !== currecnt_css_definition.value),
    );

    const old_css_definitions = remove_old_css_definition || [];

    const new_note = {
      ...note,
      class: [...old_css_definitions, currecnt_css_definition.value],
    };

    live.pushEvent("update_note", new_note);
    text_content = note_settings.remove_action_time_trigger(text_content);
    focusEditableDiv();
  };
</script>

<Command.Group {heading}>
  {#each css_definitions as css_definition}
    <Command.Item value={css_definition.key} onSelect={on_select}>
      {#if decorator}
        <p class={cn(css_definition.value, "mr-sm")}>A</p>
      {/if}
      {css_definition.label}
    </Command.Item>
  {/each}
</Command.Group>
