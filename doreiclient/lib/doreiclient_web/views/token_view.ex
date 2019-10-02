defmodule DoreiclientWeb.TokenView do
  use DoreiclientWeb, :view
  alias DoreiclientWeb.TokenView

  def render("index.json", %{tokens: tokens}) do
    %{data: render_many(tokens, TokenView, "token.json")}
  end

  def render("show.json", %{token: token}) do
    %{data: render_one(token, TokenView, "token.json")}
  end

  def render("token.json", %{token: token}) do
    %{id: token.id,
      groupid: token.groupid,
      token: token.token}
  end
end
