defmodule VideoWeb.SubstanceControllerTest do
  use VideoWeb.ConnCase

  alias Video.Pantry

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:substance) do
    {:ok, substance} = Pantry.create_substance(@create_attrs)
    substance
  end

  describe "index" do
    test "lists all substances", %{conn: conn} do
      conn = get(conn, Routes.substance_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Substances"
    end
  end

  describe "new substance" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.substance_path(conn, :new))
      assert html_response(conn, 200) =~ "New Substance"
    end
  end

  describe "create substance" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.substance_path(conn, :create), substance: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.substance_path(conn, :show, id)

      conn = get(conn, Routes.substance_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Substance"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.substance_path(conn, :create), substance: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Substance"
    end
  end

  describe "edit substance" do
    setup [:create_substance]

    test "renders form for editing chosen substance", %{conn: conn, substance: substance} do
      conn = get(conn, Routes.substance_path(conn, :edit, substance))
      assert html_response(conn, 200) =~ "Edit Substance"
    end
  end

  describe "update substance" do
    setup [:create_substance]

    test "redirects when data is valid", %{conn: conn, substance: substance} do
      conn = put(conn, Routes.substance_path(conn, :update, substance), substance: @update_attrs)
      assert redirected_to(conn) == Routes.substance_path(conn, :show, substance)

      conn = get(conn, Routes.substance_path(conn, :show, substance))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, substance: substance} do
      conn = put(conn, Routes.substance_path(conn, :update, substance), substance: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Substance"
    end
  end

  describe "delete substance" do
    setup [:create_substance]

    test "deletes chosen substance", %{conn: conn, substance: substance} do
      conn = delete(conn, Routes.substance_path(conn, :delete, substance))
      assert redirected_to(conn) == Routes.substance_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.substance_path(conn, :show, substance))
      end
    end
  end

  defp create_substance(_) do
    substance = fixture(:substance)
    %{substance: substance}
  end
end
