defmodule DoreiclientWeb.GroupView do
  use DoreiclientWeb, :view
  alias DoreiclientWeb.GroupView

  def render("groups.json", %{groups: groups}) do
    %{data: render_many(groups, GroupView, "group.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{
      name: group.name,
      description: group.description,
      id: group.id
    }
  end
end