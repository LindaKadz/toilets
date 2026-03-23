defmodule Toilets.Repo.Migrations.CreateToilets do
  use Ecto.Migration

  def change do
    create table(:toilets) do
      add :name, :string, null: false
      add :location, :string, null: false
      add :public_availability, :string, null: false
      add :currently_available, :boolean, null: false
      add :female_essentials, :boolean
      add :city, :string
      add :state, :string
      add :country, :string
      add :zip_code, :string
      add :creator_id, references(:users, on_delete: :nilify_all)
      add :updater_id, references(:users, on_delete: :nilify_all)
      add :notes, :text

      timestamps(type: :utc_datetime)
    end

    create index(:toilets, [:creator_id])
    create index(:toilets, [:updater_id])
  end
end
