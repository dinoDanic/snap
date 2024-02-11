export type CssDefinition = {
  value: string
  label: string
}

export type CssGroup = {
  heading: string
  css_definitions: CssDefinition[]
  decorator: boolean
  key: string
}

export const text_colors: CssDefinition[] = [
  { value: "text-primary", label: "Primary" },
  { value: "text-muted", label: "Muted" },
  { value: "text-destructive", label: "Red" },
  { value: "text-gray-300", label: "Gray" },
  { value: "text-brown-300", label: "Brown" },
  { value: "text-orange-300", label: "Orange" },
  { value: "text-yellow-300", label: "Yellow" },
  { value: "text-green-300", label: "Green" },
  { value: "text-blue-300", label: "Blue" },
  { value: "text-purple-300", label: "Purple" },
  { value: "text-pink-300", label: "Pink" }
]

export const text_sizes: CssDefinition[] = [
  { value: "text-3xl", label: "Heading 1" },
  { value: "text-xl", label: "Heading 2" },
  { value: "text-lg", label: "Heading 3" },
  { value: "text-md", label: "Paragraph" }
]

export const css_groups: CssGroup[] = [
  { heading: "Colors", css_definitions: text_colors, decorator: true, key: "color" },
  { heading: "Text", css_definitions: text_sizes, decorator: false, key: "text" },
]


