defmodule Video.CocktailbarTest do
  use Video.DataCase

  alias Video.Cocktailbar

  describe "cocktails" do
    alias Video.Cocktailbar.Cocktail

    @valid_attrs %{image: "some image", name: "some name", recipe: "some recipe"}
    @update_attrs %{image: "some updated image", name: "some updated name", recipe: "some updated recipe"}
    @invalid_attrs %{image: nil, name: nil, recipe: nil}

    def cocktail_fixture(attrs \\ %{}) do
      {:ok, cocktail} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cocktailbar.create_cocktail()

      cocktail
    end

    test "list_cocktails/0 returns all cocktails" do
      cocktail = cocktail_fixture()
      assert Cocktailbar.list_cocktails() == [cocktail]
    end

    test "get_cocktail!/1 returns the cocktail with given id" do
      cocktail = cocktail_fixture()
      assert Cocktailbar.get_cocktail!(cocktail.id) == cocktail
    end

    test "create_cocktail/1 with valid data creates a cocktail" do
      assert {:ok, %Cocktail{} = cocktail} = Cocktailbar.create_cocktail(@valid_attrs)
      assert cocktail.image == "some image"
      assert cocktail.name == "some name"
      assert cocktail.recipe == "some recipe"
    end

    test "create_cocktail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cocktailbar.create_cocktail(@invalid_attrs)
    end

    test "update_cocktail/2 with valid data updates the cocktail" do
      cocktail = cocktail_fixture()
      assert {:ok, %Cocktail{} = cocktail} = Cocktailbar.update_cocktail(cocktail, @update_attrs)
      assert cocktail.image == "some updated image"
      assert cocktail.name == "some updated name"
      assert cocktail.recipe == "some updated recipe"
    end

    test "update_cocktail/2 with invalid data returns error changeset" do
      cocktail = cocktail_fixture()
      assert {:error, %Ecto.Changeset{}} = Cocktailbar.update_cocktail(cocktail, @invalid_attrs)
      assert cocktail == Cocktailbar.get_cocktail!(cocktail.id)
    end

    test "delete_cocktail/1 deletes the cocktail" do
      cocktail = cocktail_fixture()
      assert {:ok, %Cocktail{}} = Cocktailbar.delete_cocktail(cocktail)
      assert_raise Ecto.NoResultsError, fn -> Cocktailbar.get_cocktail!(cocktail.id) end
    end

    test "change_cocktail/1 returns a cocktail changeset" do
      cocktail = cocktail_fixture()
      assert %Ecto.Changeset{} = Cocktailbar.change_cocktail(cocktail)
    end
  end
end
