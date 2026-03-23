defmodule Toilets.Bathrooms.Toilet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "toilets" do
    field :name, :string
    field :location, :string
    field :notes, :string
    field :city, :string
    field :state, :string
    field :country, :string
    field :zip_code, :string
    field :public_availability, :string
    field :currently_available, :boolean
    field :female_essentials, :boolean

    belongs_to :creator, Toilets.Accounts.User, foreign_key: :creator_id
    belongs_to :updater, Toilets.Accounts.User, foreign_key: :updater_id

    timestamps(type: :utc_datetime)
  end

  def create_toilet_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:name, :location, :notes, :public_availability, :currently_available, :female_essentials,
    :creator_id, :updater_id, :city, :state, :country, :zip_code])
    |> validate_required([:name, :location, :notes, :public_availability, :currently_available])
  end
end
