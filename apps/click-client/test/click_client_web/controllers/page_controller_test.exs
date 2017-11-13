defmodule ClickClientWeb.PageControllerTest do
  use ClickClientWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "123"
  end
end
