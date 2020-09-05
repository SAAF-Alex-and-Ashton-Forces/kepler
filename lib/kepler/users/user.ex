defmodule Kepler.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :username, :string

    pow_user_fields()

    timestamps()
  end

  @impl PowAssent.Ecto.Schema
  def user_identity_changeset(user_or_changeset, user_identity, attrs, user_id_attrs) do
    IO.inspect(attrs, label: "attrs")

    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:name, :username])
    |> pow_assent_user_identity_changeset(user_identity, attrs, user_id_attrs)
  end
end
