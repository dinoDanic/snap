export type Session = {
  id: number;
  name: string;
  windows: Window[];
};

export type Window = {
  id: number;
  name: string;
  panes: Pane[];
};

export type Pane = {
  id: number;
  name: string;
  notes: Note[];
};

export type Note = {
  note: string | null;
  class?: string[] | null
};


