defmodule Doreiclient.Accounts.Guardian do
  use Guardian, otp_app: :doreiclient
  alias Doreiclient.Accounts
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end
  def resource_from_claims(claims) do
    user = claims["sub"]
    |> Accounts.get_user!
    {:ok, user}
  end
end