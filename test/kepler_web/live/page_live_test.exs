defmodule KeplerWeb.PageLiveTest do
  use KeplerWeb.ConnCase
  alias Kepler.Users.User

  import Phoenix.LiveViewTest

  setup %{conn: conn} do
    # Add user to conn so we know we've got some authentication
    user = %User{email: "test@example.com"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :my_app)

    {:ok, conn: conn}
  end

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Phoenix!"
    assert render(page_live) =~ "Welcome to Phoenix!"
  end
end
