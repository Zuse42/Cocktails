defmodule Video.Cocktailbar do
  @moduledoc """
  The Cocktailbar context.
  """

  import Ecto.Query, warn: false
  alias Video.Repo

  alias Video.Cocktailbar.Cocktail

  @doc """
  Returns the list of cocktails.

  ## Examples

      iex> list_cocktails()
      [%Cocktail{}, ...]

  """
  def list_cocktails do
    Repo.all(Cocktail)
  end

  @doc """
  Gets a single cocktail.

  Raises `Ecto.NoResultsError` if the Cocktail does not exist.

  ## Examples

      iex> get_cocktail!(123)
      %Cocktail{}

      iex> get_cocktail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cocktail!(id), do: Repo.get!(Cocktail, id)

  @doc """
  Creates a cocktail.

  ## Examples

      iex> create_cocktail(%{field: value})
      {:ok, %Cocktail{}}

      iex> create_cocktail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cocktail(attrs \\ %{}) do
    %Cocktail{}
    |> Cocktail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cocktail.

  ## Examples

      iex> update_cocktail(cocktail, %{field: new_value})
      {:ok, %Cocktail{}}

      iex> update_cocktail(cocktail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cocktail(%Cocktail{} = cocktail, attrs) do
    cocktail
    |> Cocktail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cocktail.

  ## Examples

      iex> delete_cocktail(cocktail)
      {:ok, %Cocktail{}}

      iex> delete_cocktail(cocktail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cocktail(%Cocktail{} = cocktail) do
    Repo.delete(cocktail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cocktail changes.

  ## Examples

      iex> change_cocktail(cocktail)
      %Ecto.Changeset{data: %Cocktail{}}

  """
  def change_cocktail(%Cocktail{} = cocktail, attrs \\ %{}) do
    Cocktail.changeset(cocktail, attrs)
  end
end
