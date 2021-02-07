defmodule Video.Repo.Migrations.CreateIngridients do
  use Ecto.Migration

  def change do
    create table(:ingridients) do
      add :amount, :float
      add :unit, :string
      add :cocktail_id, references(:cocktails, on_delete: :nothing)

      timestamps()
    end

    create index(:ingridients, [:cocktail_id])
  end
end
