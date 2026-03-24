defmodule Toilets.ToiletsTest do
  use Toilets.DataCase

  alias Toilets.Bathrooms
  alias Toilets.Bathrooms.Toilet

  import Toilets.ToiletFixtures
  import Toilets.AccountsFixtures

  describe "list_toilet/1" do
    test "checks all the required fields are to be set" do
      {:error, changeset} = Bathrooms.list_toilet(%{
        notes: "Foo Bar",
        public_availability: "Available",
        currently_available: true,
        })

      assert %{
               name: ["can't be blank"],
               location: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "creates a new toilet record" do
      user = user_fixture()
      toilet_attrs = %{
        name: "Shake Shack",
        location: "123 Bio Road Street",
        notes: "Bar Foo",
        public_availability: "Available",
        currently_available: true,
        creator_id: user.id
      }

      {:ok, toilet} = Bathrooms.list_toilet(valid_toilet_attributes(toilet_attrs))
      assert toilet.notes == toilet_attrs[:notes]
    end
  end

  describe "change_create_toilet_registration/2" do
    test "returns a changeset" do
      assert %Ecto.Changeset{} = changeset = Bathrooms.change_create_toilet_registration(%Toilet{})
      assert changeset.required == [:name, :location, :notes, :public_availability, :currently_available]
    end

    test "allows fields to be set" do
      user = user_fixture()
      toilet_attrs = %{
        name: "Shake Shack",
        location: "123 Bio Road Street",
        notes: "Foo Bar",
        public_availability: "Available",
        currently_available: true,
        creator_id: user.id
      }

      changeset =
        Bathrooms.change_create_toilet_registration(
          %Toilet{},
          valid_toilet_attributes(toilet_attrs)
        )

      assert changeset.valid?
      assert get_change(changeset, :name) == toilet_attrs[:name]
      assert get_change(changeset, :location) == toilet_attrs[:location]
      assert get_change(changeset, :notes) == toilet_attrs[:notes]
      assert get_change(changeset, :public_availability) == toilet_attrs[:public_availability]
    end
  end

  describe "all_toilets" do
    test "returns all toilets" do
      _toilet_1 = toilet_fixture()
      _toilet_2 = toilet_fixture()

      assert length(Bathrooms.all_toilets()) == 2
    end
  end
end
