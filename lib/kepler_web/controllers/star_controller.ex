defmodule KeplerWeb.StarController do
  use KeplerWeb, :controller
  alias Kepler.Repo

  def index(conn, _params) do
    user = conn.assigns.current_user |> Repo.preload([:user_identities])
    IO.inspect(user, label: "user")

    stars = Kepler.Github.fetch_stars(user.username)

    render(conn, "show.html", stars: stars)
  end
end
