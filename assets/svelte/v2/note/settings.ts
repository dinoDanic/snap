const remove_action_time_trigger = (text_content: string) => {
  return text_content.replace(note_settings.action_time_trigger, "");
}

export const note_settings = {
  action_time_trigger: "/",
  remove_action_time_trigger: remove_action_time_trigger
} as const

