defmodule Play do
  @spec increment(integer(), integer()) :: integer()
  def increment(a, b) do
    a + b
  end

  @spec call_test :: integer()
  def call_test do
    increment(3, 3)
  end
end
