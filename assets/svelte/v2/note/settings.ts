import { CssDefinition } from "$lib/components/ui/command-lite/css";

const remove_action_time_trigger = (text_content: string) => {
  return text_content.replace(note_settings.action_time_trigger, "");
}

const create_command_key = (key: string, css_definition: CssDefinition): string => `${key}-${css_definition.label}`

export const note_settings = {
  action_time_trigger: "/",
  remove_action_time_trigger: remove_action_time_trigger,
  create_command_key: create_command_key
} as const



