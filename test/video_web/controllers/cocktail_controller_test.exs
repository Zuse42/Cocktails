defmodule VideoWeb.CocktailControllerTest do
  use VideoWeb.ConnCase

  alias Video.Cocktailbar

  @create_attrs %{image: "some image", name: "some name", recipe: "some recipe"}
  @update_attrs %{image: "some updated image", name: "some updated name", recipe: "some updated recipe"}
  @invalid_attrs %{image: nil, name: nil, recipe: nil}

  def fixture(:cocktail) do
    {:ok, cocktail} = Cocktailbar.create_cocktail(@create_attrs)
    cocktail
  end

  describe "index" do
    test "lists all cocktails", %{conn: conn} do
      conn = get(conn, Routes.cocktail_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Cocktails"
    end
  end

  describe "new cocktail" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.cocktail_path(conn, :new))
      assert html_response(conn, 200) =~ "New Cocktail"
    end
  end

  describe "create cocktail" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cocktail_path(conn, :create), cocktail: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.cocktail_path(conn, :show, id)

      conn = get(conn, Routes.cocktail_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Cocktail"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cocktail_path(conn, :create), cocktail: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Cocktail"
    end
  end

  describe "edit cocktail" do
    setup [:create_cocktail]

    test "renders form for editing chosen cocktail", %{conn: conn, cocktail: cocktail} do
      conn = get(conn, Routes.cocktail_path(conn, :edit, cocktail))
      assert html_response(conn, 200) =~ "Edit Cocktail"
    end
  end

  describe "update cocktail" do
    setup [:create_cocktail]

    test "redirects when data is valid", %{conn: conn, cocktail: cocktail} do
      conn = put(conn, Routes.cocktail_path(conn, :update, cocktail), cocktail: @update_attrs)
      assert redirected_to(conn) == Routes.cocktail_path(conn, :show, cocktail)

      conn = get(conn, Routes.cocktail_path(conn, :show, cocktail))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, cocktail: cocktail} do
      conn = put(conn, Routes.cocktail_path(conn, :update, cocktail), cocktail: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Cocktail"
    end
  end

  describe "delete cocktail" do
    setup [:create_cocktail]

    test "deletes chosen cocktail", %{conn: conn, cocktail: cocktail} do
      conn = delete(conn, Routes.cocktail_path(conn, :delete, cocktail))
      assert redirected_to(conn) == Routes.cocktail_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.cocktail_path(conn, :show, cocktail))
      end
    end
  end

  defp create_cocktail(_) do
    cocktail = fixture(:cocktail)
    %{cocktail: cocktail}
  end
end
