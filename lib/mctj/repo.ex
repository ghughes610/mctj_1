defmodule Mctj.Repo do
  use Ecto.Repo,
    otp_app: :mctj,
    adapter: Ecto.Adapters.Postgres
end
