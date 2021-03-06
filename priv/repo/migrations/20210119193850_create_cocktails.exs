defmodule Video.Repo.Migrations.CreateCocktails do
  use Ecto.Migration

  def change do
    create table(:cocktails) do
      add :name, :string
      add :image, :string
      add :recipe, :text

      timestamps()
    end

  end
end
