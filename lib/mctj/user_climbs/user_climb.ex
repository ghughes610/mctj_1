defmodule Mctj.UserClimbs.UserClimb do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_climbs" do
    field :metadata, :map
    field :send_date, :date
    field :sessions, :integer

    timestamps()

    belongs_to :user, Mctj.Accounts.User
    belongs_to :climb, Mctj.Climbs.Climb
  end

  def changeset(user_climb, attrs) do
    user_climb
    |> cast(attrs, [:climb_id, :user_id, :metadata, :send_date, :sessions])
  end
end
