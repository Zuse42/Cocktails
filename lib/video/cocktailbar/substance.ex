defmodule Video.Cocktailbar.Substance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "substances" do
    field :name, :string
    has_many :ingridients, Video.Cocktailbar.Ingredient

    timestamps()
  end

  @doc false
  def changeset(substance, attrs) do
    substance
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
