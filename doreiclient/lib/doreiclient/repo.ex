defmodule Doreiclient.Repo do
  use Ecto.Repo,
    otp_app: :doreiclient,
    adapter: Ecto.Adapters.Postgres
end
