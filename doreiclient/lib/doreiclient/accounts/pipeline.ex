defmodule Doreiclient.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :doreiclient,
    error_handler: Doreiclient.Accounts.ErrorHandler,
    module: Doreiclient.Accounts.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end