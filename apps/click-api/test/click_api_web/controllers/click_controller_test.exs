defmodule ClickAPIWeb.ClickControllerTest do
  use ClickAPIWeb.ConnCase
  import ClickAPI.Factory

  describe "index/2" do
    test "returns click count", %{conn: conn} do
      insert_list(2, :click)

      response =
        conn
        |> get(click_path(conn, :index), %{})
        |> json_response(200)

      assert response == %{"count" => 2} # v2
    end
  end

  describe "create/2" do
    test "adds click and returns click count", %{conn: conn} do
      insert_list(2, :click)

      response =
        conn
        |> post(click_path(conn, :create), %{})
        |> json_response(200)

      assert response == %{"count" => 3}
    end
  end
end
