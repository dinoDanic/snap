# defmodule Snap.Runtime.Server do
#   use GenServer
#
#   @type t :: pid()
#   @me :wilma
#
#   ## client process
#   def start_link(_) do
#     GenServer.start_link(__MODULE__, nil, name: @me)
#   end
#
#   ## server process
#   def init(_) do
#     {:ok, %{session: %{}}}
#   end
#
#   def handle_call(:load_session, _from, state) do
#     newstate = Map.put(state, :session, %{name: "test"})
#     {:reply, newstate, %{session: %{name: "koji kurac kome ovo treja"}}}
#   end
#
#   # def handle_call({:load_session}) do
#   #   session = %{name: "test"}
#   #   {:reply, session}
#   # end
# end
