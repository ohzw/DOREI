defmodule Doreiclient.Accounts.Guardian do
  use Guardian, otp_app: :doreiclient
  alias Doreiclient.Accounts

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end
  def subject_for_token(_, _) do
    {:error, :invalid_resource_id}
  end

  def resource_from_claims(claims) do
    user = claims["sub"]
    |> Accounts.get_user!
    {:ok, user}
  end
  def resource_from_claims(_), do: {:error, :invalid_claims}
end