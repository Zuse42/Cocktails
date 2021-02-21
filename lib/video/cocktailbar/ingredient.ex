defmodule Video.Cocktailbar.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingridients" do
    field :amount, :float
    field :unit, :string
    field :substance_id, :id
    belongs_to :substances, Video.Pantry.Substance
    belongs_to :cocktails, Video.Cocktailbar.Cocktail

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:amount, :unit])
    |> validate_required([:amount, :unit])
  end
end
