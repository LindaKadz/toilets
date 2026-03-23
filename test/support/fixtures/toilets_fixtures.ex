defmodule Toilets.ToiletFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Toilets.Bathrooms` context.
  """

  import Toilets.AccountsFixtures

  def valid_toilet_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: "Shake Shack",
      location: "123 Bio Road Street",
      notes: "Foo Bar",
      public_availability: "Available",
      currently_available: true,
      creator_id: user_fixture().id
    })
  end

  def toilet_fixture(attrs \\ %{}) do
    {:ok, toilet} =
      attrs
      |> valid_toilet_attributes()
      |> Toilets.Bathrooms.list_toilet()

    toilet
  end
end
