defmodule KeplerWeb.PageController do
  use KeplerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def ui_ref(conn, _params) do
    render(conn, "ui_ref.html")
  end
end
