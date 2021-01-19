defmodule Video.Cocktailbar.Cocktail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cocktails" do
    field :image, :binary
    field :name, :string
    field :recipe, :string

    timestamps()
  end

  @doc false
  def changeset(cocktail, attrs) do
    cocktail
    |> cast(attrs, [:name, :image, :recipe])
    |> validate_required([:name, :recipe])
  end
end
