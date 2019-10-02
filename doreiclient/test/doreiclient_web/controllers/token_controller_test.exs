defmodule DoreiclientWeb.TokenControllerTest do
  use DoreiclientWeb.ConnCase

  alias Doreiclient.Verify
  alias Doreiclient.Verify.Token

  @create_attrs %{
    groupid: 42,
    token: "some token"
  }
  @update_attrs %{
    groupid: 43,
    token: "some updated token"
  }
  @invalid_attrs %{groupid: nil, token: nil}

  def fixture(:token) do
    {:ok, token} = Verify.create_token(@create_attrs)
    token
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tokens", %{conn: conn} do
      conn = get(conn, Routes.token_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create token" do
    test "renders token when data is valid", %{conn: conn} do
      conn = post(conn, Routes.token_path(conn, :create), token: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.token_path(conn, :show, id))

      assert %{
               "id" => id,
               "groupid" => 42,
               "token" => "some token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.token_path(conn, :create), token: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update token" do
    setup [:create_token]

    test "renders token when data is valid", %{conn: conn, token: %Token{id: id} = token} do
      conn = put(conn, Routes.token_path(conn, :update, token), token: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.token_path(conn, :show, id))

      assert %{
               "id" => id,
               "groupid" => 43,
               "token" => "some updated token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, token: token} do
      conn = put(conn, Routes.token_path(conn, :update, token), token: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete token" do
    setup [:create_token]

    test "deletes chosen token", %{conn: conn, token: token} do
      conn = delete(conn, Routes.token_path(conn, :delete, token))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.token_path(conn, :show, token))
      end
    end
  end

  defp create_token(_) do
    token = fixture(:token)
    {:ok, token: token}
  end
end
