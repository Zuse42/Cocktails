defmodule VideoWeb.CocktailController do
  use VideoWeb, :controller

  alias Video.Cocktailbar
  alias Video.Cocktailbar.Cocktail

  def index(conn, _params) do
    cocktails = Cocktailbar.list_cocktails()
    render(conn, "index.html", cocktails: cocktails)
  end

  def new(conn, _params) do
    changeset = Cocktailbar.change_cocktail(%Cocktail{})
    substances = Video.Pantry.list_substances()
    IO.inspect substances
    render(conn, "new.html", changeset: changeset, substances: substances)
  end

  def create(conn, %{"cocktail" => cocktail_params}) do
    case Cocktailbar.create_cocktail(cocktail_params) do
      {:ok, cocktail} ->
        conn
        |> put_flash(:info, "Cocktail created successfully.")
        |> redirect(to: Routes.cocktail_path(conn, :show, cocktail))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cocktail = Cocktailbar.get_cocktail!(id)
    render(conn, "show.html", cocktail: cocktail)
  end

  def edit(conn, %{"id" => id}) do
    cocktail = Cocktailbar.get_cocktail!(id)
    changeset = Cocktailbar.change_cocktail(cocktail)
    render(conn, "edit.html", cocktail: cocktail, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cocktail" => cocktail_params}) do
    cocktail = Cocktailbar.get_cocktail!(id)

    case Cocktailbar.update_cocktail(cocktail, cocktail_params) do
      {:ok, cocktail} ->
        conn
        |> put_flash(:info, "Cocktail updated successfully.")
        |> redirect(to: Routes.cocktail_path(conn, :show, cocktail))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cocktail: cocktail, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cocktail = Cocktailbar.get_cocktail!(id)
    {:ok, _cocktail} = Cocktailbar.delete_cocktail(cocktail)

    conn
    |> put_flash(:info, "Cocktail deleted successfully.")
    |> redirect(to: Routes.cocktail_path(conn, :index))
  end
end
