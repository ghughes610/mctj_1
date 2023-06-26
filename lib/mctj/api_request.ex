defmodule Mctj.ApiRequest do
  import Ecto.Query, warn: false

  alias Mctj.Repo
  alias Mctj.ApiRequests.ApiRequest

  def list_requests, do: Repo.all(ApiRequest)

  def get_request!(id), do: Repo.get!(ApiRequest, id)

  def create_area(attrs \\ %{}) do
    %ApiRequest{}
    |> ApiRequest.changeset(attrs)
    |> Repo.insert()
  end
end
