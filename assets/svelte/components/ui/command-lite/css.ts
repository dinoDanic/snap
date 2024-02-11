export type CssDefinition = {
  value: string
  label: string
  key: string
}

export const text_colors: CssDefinition[] = [
  { value: "text-primary", label: "Primary", key: "color-Primary" },
  { value: "text-muted", label: "Muted", key: "color-Muted" },
  { value: "text-destructive", label: "Red", key: "color-Red" },
  { value: "text-gray-300", label: "Gray", key: "color-Gray" },
  { value: "text-brown-300", label: "Brown", key: "color-Brown" },
  { value: "text-orange-300", label: "Orange", key: "color-Orange" },
  { value: "text-yellow-300", label: "Yellow", key: "color-Yellow" },
  { value: "text-green-300", label: "Green", key: "color-Green" },
  { value: "text-blue-300", label: "Blue", key: "color-Blue" },
  { value: "text-purple-300", label: "Purple", key: "color-Purple" },
  { value: "text-pink-300", label: "Pink", key: "color-Pink" },
]

export const text_sizes: CssDefinition[] = [
  { value: "text-3xl", label: "Heading 1", key: "text-Heading 1" },
  { value: "text-xl", label: "Heading 2", key: "text-Heading 2" },
  { value: "text-lg", label: "Heading 3", key: "text-Heading 3" },
  { value: "text-md", label: "Paragraph", key: "text-Paragraph" }
]
