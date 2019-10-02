defmodule DoreiclientWeb.TokenController do
  use DoreiclientWeb, :controller

  alias Doreiclient.Verify
  alias Doreiclient.Verify.Token

  action_fallback DoreiclientWeb.FallbackController

  def index(conn, _params) do
    tokens = Verify.list_tokens()
    render(conn, "index.json", tokens: tokens)
  end

  def create(conn, %{"token" => token_params}) do
    Phonenix.Token.sign(conn,"invite to group",token)# in progress
    with {:ok, %Token{} = token} <- Verify.create_token(token_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.token_path(conn, :show, token))
      |> render("show.json", token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    token = Verify.get_token!(id)
    render(conn, "show.json", token: token)
  end

  def update(conn, %{"id" => id, "token" => token_params}) do
    token = Verify.get_token!(id)

    with {:ok, %Token{} = token} <- Verify.update_token(token, token_params) do
      render(conn, "show.json", token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    token = Verify.get_token!(id)

    with {:ok, %Token{}} <- Verify.delete_token(token) do
      send_resp(conn, :no_content, "")
    end
  end
end
