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


export const font_weights: CssDefinition[] = [
  { value: "font-bold", label: "Bold" },
  { value: "font-medium", label: "Medium" },
  { value: "font-normal", label: "Normal" },
  { value: "font-light", label: "Light" }
]


export const text_decorators: CssDefinition[] = [
  { value: "underline", label: "Underline" },
  { value: "overline", label: "Overline" },
  { value: "line-through", label: "Through" },
  { value: "no-underline", label: "Normal" }
]

export const css_groups: CssGroup[] = [
  { heading: "Colors", css_definitions: text_colors, decorator: true, key: "color" },
  { heading: "Weight", css_definitions: font_weights, decorator: true, key: "weight" },
  { heading: "Decorators", css_definitions: text_decorators, decorator: true, key: "decorators" },
  { heading: "Text", css_definitions: text_sizes, decorator: false, key: "text" },
]


