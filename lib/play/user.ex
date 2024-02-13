defmodule Play.Task do
  defstruct [:name, :date]

  @type t :: %Play.Task{name: binary, date: integer}
end

defmodule Play.Create do
  @spec create_task(Play.Task.t()) :: Play.Task.t()
  def create_task(%Play.Task{name: "dino"}) do
    IO.puts(~c"lol>")
    %Play.Task{name: "name", date: 2}
  end

  def create_task(%Play.Task{name: "nina"}) do
    IO.puts(~c"lol 2>")
    %Play.Task{name: "name", date: 2}
  end
end
