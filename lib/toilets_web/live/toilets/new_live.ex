defmodule ToiletsWeb.ToiletsNewLive do
  use ToiletsWeb, :live_view

  alias Toilets.Bathrooms
  alias Toilets.Bathrooms.Toilet

  def mount(_params, _session, socket) do
    changeset = Bathrooms.change_create_toilet_registration(%Toilet{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "toilet")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end

  def handle_event("validate", %{"toilet" => toilet_params}, socket) do
    changeset = Bathrooms.change_create_toilet_registration(%Toilet{}, toilet_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  def handle_event("save", %{"toilet" => toilet_params}, socket) do
    params = Map.put(toilet_params, "creator_id", socket.assigns.current_user.id)
    case Bathrooms.list_toilet(params) do
      {:ok, toilet} ->
        {:noreply,
          socket
          |> put_flash(:info, "#{toilet.name} has been successfully created!")
          |> redirect(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end
end
