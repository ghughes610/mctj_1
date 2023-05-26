# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mctj.Repo.insert!(%Mctj.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Mctj.Repo
alias Mctj.Climbs.Climb

Repo.insert!(Climb.changeset(%Climb{}, %{name: "Climb 1", grade: "5.10a"}))
