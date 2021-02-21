defmodule Video.Pantry do
  @moduledoc """
  The Pantry context.
  """

  import Ecto.Query, warn: false
  alias Video.Repo

  alias Video.Pantry.Substance

  @doc """
  Returns the list of substances.

  ## Examples

      iex> list_substances()
      [%Substance{}, ...]

  """
  def list_substances do
    Repo.all(Substance)
  end

  @doc """
  Gets a single substance.

  Raises `Ecto.NoResultsError` if the Substance does not exist.

  ## Examples

      iex> get_substance!(123)
      %Substance{}

      iex> get_substance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_substance!(id), do: Repo.get!(Substance, id)

  @doc """
  Creates a substance.

  ## Examples

      iex> create_substance(%{field: value})
      {:ok, %Substance{}}

      iex> create_substance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_substance(attrs \\ %{}) do
    %Substance{}
    |> Substance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a substance.

  ## Examples

      iex> update_substance(substance, %{field: new_value})
      {:ok, %Substance{}}

      iex> update_substance(substance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_substance(%Substance{} = substance, attrs) do
    substance
    |> Substance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a substance.

  ## Examples

      iex> delete_substance(substance)
      {:ok, %Substance{}}

      iex> delete_substance(substance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_substance(%Substance{} = substance) do
    Repo.delete(substance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking substance changes.

  ## Examples

      iex> change_substance(substance)
      %Ecto.Changeset{data: %Substance{}}

  """
  def change_substance(%Substance{} = substance, attrs \\ %{}) do
    Substance.changeset(substance, attrs)
  end
end
