defmodule Doreiclient.VerifyTest do
  use Doreiclient.DataCase

  alias Doreiclient.Verify

  describe "tokens" do
    alias Doreiclient.Verify.Token

    @valid_attrs %{groupid: 42, token: "some token"}
    @update_attrs %{groupid: 43, token: "some updated token"}
    @invalid_attrs %{groupid: nil, token: nil}

    def token_fixture(attrs \\ %{}) do
      {:ok, token} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Verify.create_token()

      token
    end

    test "list_tokens/0 returns all tokens" do
      token = token_fixture()
      assert Verify.list_tokens() == [token]
    end

    test "get_token!/1 returns the token with given id" do
      token = token_fixture()
      assert Verify.get_token!(token.id) == token
    end

    test "create_token/1 with valid data creates a token" do
      assert {:ok, %Token{} = token} = Verify.create_token(@valid_attrs)
      assert token.groupid == 42
      assert token.token == "some token"
    end

    test "create_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Verify.create_token(@invalid_attrs)
    end

    test "update_token/2 with valid data updates the token" do
      token = token_fixture()
      assert {:ok, %Token{} = token} = Verify.update_token(token, @update_attrs)
      assert token.groupid == 43
      assert token.token == "some updated token"
    end

    test "update_token/2 with invalid data returns error changeset" do
      token = token_fixture()
      assert {:error, %Ecto.Changeset{}} = Verify.update_token(token, @invalid_attrs)
      assert token == Verify.get_token!(token.id)
    end

    test "delete_token/1 deletes the token" do
      token = token_fixture()
      assert {:ok, %Token{}} = Verify.delete_token(token)
      assert_raise Ecto.NoResultsError, fn -> Verify.get_token!(token.id) end
    end

    test "change_token/1 returns a token changeset" do
      token = token_fixture()
      assert %Ecto.Changeset{} = Verify.change_token(token)
    end
  end
end
