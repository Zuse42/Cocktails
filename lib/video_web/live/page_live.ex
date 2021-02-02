defmodule VideoWeb.PageLive do
  use VideoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    cocktails = Video.Cocktailbar.list_cocktails()

    {:ok, socket |> assign(:cocktails, cocktails)}
  end

  def handle_event("select", payload, socket) do
    IO.inspect payload
    {:noreply, socket}
  end

  def handle_event("SelectSomething", payload, socket) do
    IO.inspect payload
    {:noreply, socket}
  end

  def handle_event("Cockteil_selected", payload, socket) do
    IO.inspect payload
    {:noreply, socket}
  end

end
