defmodule Video.PantryTest do
  use Video.DataCase

  alias Video.Pantry

  describe "substances" do
    alias Video.Pantry.Substance

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def substance_fixture(attrs \\ %{}) do
      {:ok, substance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pantry.create_substance()

      substance
    end

    test "list_substances/0 returns all substances" do
      substance = substance_fixture()
      assert Pantry.list_substances() == [substance]
    end

    test "get_substance!/1 returns the substance with given id" do
      substance = substance_fixture()
      assert Pantry.get_substance!(substance.id) == substance
    end

    test "create_substance/1 with valid data creates a substance" do
      assert {:ok, %Substance{} = substance} = Pantry.create_substance(@valid_attrs)
      assert substance.name == "some name"
    end

    test "create_substance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pantry.create_substance(@invalid_attrs)
    end

    test "update_substance/2 with valid data updates the substance" do
      substance = substance_fixture()
      assert {:ok, %Substance{} = substance} = Pantry.update_substance(substance, @update_attrs)
      assert substance.name == "some updated name"
    end

    test "update_substance/2 with invalid data returns error changeset" do
      substance = substance_fixture()
      assert {:error, %Ecto.Changeset{}} = Pantry.update_substance(substance, @invalid_attrs)
      assert substance == Pantry.get_substance!(substance.id)
    end

    test "delete_substance/1 deletes the substance" do
      substance = substance_fixture()
      assert {:ok, %Substance{}} = Pantry.delete_substance(substance)
      assert_raise Ecto.NoResultsError, fn -> Pantry.get_substance!(substance.id) end
    end

    test "change_substance/1 returns a substance changeset" do
      substance = substance_fixture()
      assert %Ecto.Changeset{} = Pantry.change_substance(substance)
    end
  end
end
