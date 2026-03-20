defmodule Toilets.Repo do
  use Ecto.Repo,
    otp_app: :toilets,
    adapter: Ecto.Adapters.Postgres
end
