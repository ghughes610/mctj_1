defmodule Mctj.ApiRequests.ApiRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api_requests" do
    field :url, :string
    field :request_date, :utc_datetime
    field :metadata, :map, default: %{}

    timestamps()

    belongs_to :user, Mctj.Accounts.User
  end

  @doc false
  def changeset(api_request, attrs) do
    api_request
    |> cast(attrs, [:url, :request_date, :user_id, :metadata])
    |> validate_required([:url, :request_date, :user_id, :metadata])
  end
end
