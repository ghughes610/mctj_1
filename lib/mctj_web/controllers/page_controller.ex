defmodule MctjWeb.PageController do
  use MctjWeb, :controller

  def index(conn, _params) do
    IO.puts("running page controller")
    render(conn, "index.html", current_user: conn.assigns.current_user)
  end
end
