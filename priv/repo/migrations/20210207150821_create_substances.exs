defmodule Video.Repo.Migrations.CreateSubstances do
  use Ecto.Migration

  def change do
    create table(:substances) do
      add :name, :string

      timestamps()
    end

    alter table(:ingridients) do
      add :substance_id, references(:substances, on_delete: :nothing)
    end

  end
end
