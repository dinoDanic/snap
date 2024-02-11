<script lang="ts">
  import * as Command from "$lib/components/ui/command";
  import { cn } from "$lib/utils";
  import { Note } from "$lib/types";
  import { Live } from "live_svelte";
  import { CssGroup } from "../css";
  import { note_settings } from "$lib/v2/note/settings";

  export let live: Live;
  export let note: Note;
  export let text_content: string;
  export let focusEditableDiv: () => void;

  export let css_group: CssGroup;

  const on_select = (value: string) => {
    const currecnt_css_definition = css_group.css_definitions.find(
      (css_definition) =>
        note_settings.create_command_key(css_group.key, css_definition) ===
        value,
    );

    if (!currecnt_css_definition) throw Error("Did not found css definition");

    const remove_old_css_definitions = note.class?.filter((css_class) => {
      const is_css_class = css_group.css_definitions.some(
        (cd) => cd.value === css_class,
      );
      if (is_css_class) return false;
      else return true;
    });

    const old_css_definitions = remove_old_css_definitions || [];

    const new_note = {
      ...note,
      class: [...old_css_definitions, currecnt_css_definition.value],
    };

    live.pushEvent("update_note", new_note);
    text_content = note_settings.remove_action_time_trigger(text_content);
    focusEditableDiv();
  };
</script>

<Command.Group heading={css_group.heading}>
  {#each css_group.css_definitions as css_definition}
    <Command.Item
      value={note_settings.create_command_key(css_group.key, css_definition)}
      onSelect={on_select}
    >
      {#if css_group.decorator}
        <p class={cn(css_definition.value, "mr-sm")}>A</p>
      {/if}
      {css_definition.label}
    </Command.Item>
  {/each}
</Command.Group>
