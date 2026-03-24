defmodule ToiletsWeb.ToiletsIndexLive do
  use ToiletsWeb, :live_view

  alias Toilets.Bathrooms

  def mount(_params, _session, socket) do
    toilets = Bathrooms.all_toilets()
    current_user = socket.assigns.current_user

    {:ok, assign(socket, toilets: toilets, current_user: current_user)}
  end
end
