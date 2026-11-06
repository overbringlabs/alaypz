defmodule AlaypzWeb.Identity do
  @moduledoc """
  Shared claim/reclaim logic for the identity form, used by the lobby and the
  `/play` view. Each function takes a socket (with the `:form` assign,
  `as: :identity`) and returns `{outcome, socket}`:

    * `claim/2` — `:ok` (name claimed), `:taken` (form switched to reclaim
      mode), `:invalid` (validation errors on the form)
    * `reclaim/3` — `:ok` (reclaimed, or the name was free and got claimed),
      `:mismatch` (access string rejected)
  """
  alias Alaypz.Players

  import Phoenix.Component, only: [assign: 2, assign: 3, to_form: 2]

  def claim(name, socket) do
    case Players.claim_name(name) do
      {:ok, player, secret} ->
        {:ok,
         socket
         |> assign(:access_string, secret)
         |> assign(:mode, :claim)
         |> assign(:notice, "Name claimed. Keep the access string — it is shown only once.")
         |> put_name(player.name)}

      {:error, changeset} ->
        # A taken name switches the form into reclaim mode; anything else is
        # a plain validation error. changeset.errors is a keyword list.
        if Keyword.get(changeset.errors, :name) do
          {:taken,
           socket
           |> assign(:mode, :reclaim)
           |> assign(:notice, "That name is taken. Submit its access string to reclaim it.")
           |> put_name(name)}
        else
          {:invalid, assign(socket, form: to_form(changeset, as: :identity))}
        end
    end
  end

  def reclaim(name, access, socket) do
    case Players.reclaim_name(name, access) do
      {:ok, player} ->
        {:ok,
         socket
         |> assign(:mode, :claim)
         |> assign(:notice, "Name reclaimed.")
         |> put_name(player.name)}

      # The name is unknown, i.e. free: claim it instead.
      {:error, :name_not_found} ->
        claim(name, socket)

      {:error, :secret_mismatch} ->
        {:mismatch,
         assign(
           socket,
           :notice,
           "Access string does not match. Try again, or reclaim a different way."
         )}
    end
  end

  defp put_name(socket, name) do
    assign(socket, form: to_form(%{"name" => name, "access" => ""}, as: :identity))
  end

  # `start` needs the player: use the existing one, or claim it fresh.
  def resolve_or_claim(name) do
    case Players.get_by_name(name) do
      nil ->
        case Players.claim_name(name) do
          {:ok, player, secret} -> {:ok, player, secret}
          {:error, changeset} -> {:error, changeset}
        end

      player ->
        {:ok, player, nil}
    end
  end

  def name_error_message(changeset) do
    changeset.errors
    |> Keyword.get(:name)
    |> then(fn
      {message, _opts} -> message
      _ -> nil
    end)
  end
end
