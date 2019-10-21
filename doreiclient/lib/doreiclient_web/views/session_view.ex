defmodule DoreiclientWeb.SessionView do
  use DoreiclientWeb, :view

  def render("login.json", %{response: response}) do
    %{data: response}
  end

  def render("login-error.json", %{response: response}) do
    %{data: %{
      error: "Invalid request",
      error_description: "Incorrect userid or password."
      }
    }
  end

  def render("logout.json", %{response: _}) do
    %{data: %{
      success: "Request success",
      success_description: "Logout."
      }
    }
  end

  def render("logout-error.json", %{response: _}) do
    %{data: %{
      error: "Invalid request",
      error_description: "Can't logout."
      }
    }
  end

  def render("expired.json", _) do
    %{data: %{
      error: "Invalid request",
      error_description: "Access token expired."
      }
    }
  end
end