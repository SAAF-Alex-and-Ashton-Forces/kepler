defmodule Kepler.Repo do
  use Ecto.Repo,
    otp_app: :kepler,
    adapter: Ecto.Adapters.Postgres
end
