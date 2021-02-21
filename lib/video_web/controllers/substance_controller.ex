defmodule VideoWeb.SubstanceController do
  use VideoWeb, :controller

  alias Video.Pantry
  alias Video.Pantry.Substance

  def index(conn, _params) do
    substances = Pantry.list_substances()
    render(conn, "index.html", substances: substances)
  end

  def new(conn, _params) do
    changeset = Pantry.change_substance(%Substance{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"substance" => substance_params}) do
    case Pantry.create_substance(substance_params) do
      {:ok, substance} ->
        conn
        |> put_flash(:info, "Substance created successfully.")
        |> redirect(to: Routes.substance_path(conn, :show, substance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    substance = Pantry.get_substance!(id)
    render(conn, "show.html", substance: substance)
  end

  def edit(conn, %{"id" => id}) do
    substance = Pantry.get_substance!(id)
    changeset = Pantry.change_substance(substance)
    render(conn, "edit.html", substance: substance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "substance" => substance_params}) do
    substance = Pantry.get_substance!(id)

    case Pantry.update_substance(substance, substance_params) do
      {:ok, substance} ->
        conn
        |> put_flash(:info, "Substance updated successfully.")
        |> redirect(to: Routes.substance_path(conn, :show, substance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", substance: substance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    substance = Pantry.get_substance!(id)
    {:ok, _substance} = Pantry.delete_substance(substance)

    conn
    |> put_flash(:info, "Substance deleted successfully.")
    |> redirect(to: Routes.substance_path(conn, :index))
  end
end
