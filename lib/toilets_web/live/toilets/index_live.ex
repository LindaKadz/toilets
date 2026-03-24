defmodule ToiletsWeb.ToiletsIndexLive do
  use ToiletsWeb, :live_view

  alias Toilets.Bathrooms

  def mount(_params, _session, socket) do
    toilets = Bathrooms.all_toilets()

    {:ok, assign(socket, toilets: toilets)}
  end
end
