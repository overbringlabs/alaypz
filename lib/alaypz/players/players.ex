defmodule Alaypz.Players do
  @moduledoc """
  Player identity: unique names plus a one-time access string.

  The access string is shown to the owner once, at claim time. Only its
  salted SHA-256 hash is persisted, so a later duplicate submitter can
  reclaim the name by proving they hold the string (D-20261106-02).
  """

  import Bitwise
  import Ecto.Query
  import Ecto.Changeset
  alias Alaypz.Repo
  alias Alaypz.Players.Player

  @alphabet "ABCDEFGHJKMNPQRSTUVWXYZ23456789"

  @doc """
  Claims `name`, generating the access string. Returns the player and the
  access string (shown to the owner exactly once); persistence keeps only
  the salted hash.
  """
  def claim_name(name) do
    changeset =
      %Player{}
      |> Player.changeset(%{name: name})
      |> then(fn cs ->
        if cs.valid? and get_by_name(name) do
          add_error(cs, :name, "has already been taken")
        else
          cs
        end
      end)

    unless changeset.valid? do
      {:error, changeset}
    else
      salt = :crypto.strong_rand_bytes(16)
      secret = generate_access_string()

      changeset
      |> put_change(:secret_salt, salt)
      |> put_change(:secret_hash, hash(salt, secret))
      |> then(fn cs ->
        case Alaypz.Repo.insert(cs) do
          {:ok, saved} -> {:ok, saved, secret}
          {:error, insert_cs} -> {:error, insert_cs}
        end
      end)
    end
  end

  @doc "Reclaims an existing name with its access string."
  def reclaim_name(name, secret) do
    case get_by_name(name) do
      nil ->
        {:error, :name_not_found}

      player ->
        if verify_secret(player, secret) do
          {:ok, player}
        else
          {:error, :secret_mismatch}
        end
    end
  end

  @doc "Looks a player up by name (case-insensitive, trimmed)."
  def get_by_name(name) do
    Repo.one(from(p in Player, where: p.name_key == ^normalize(name)))
  end

  def get!(id), do: Repo.get!(Player, id)
  def list(), do: Repo.all(Player)

  @doc """
  Generates a 20-char access string over an unambiguous alphabet (no 0/O,
  1/I/L). Slight modulo bias (256 % 30) — fine for a name-reclaim token.
  """
  def generate_access_string() do
    letters = String.graphemes(@alphabet)

    for _ <- 1..20 do
      <<byte>> = :crypto.strong_rand_bytes(1)
      Enum.at(letters, rem(byte, length(letters)))
    end
    |> Enum.join()
  end

  @doc "Timing-safe access-string check against the stored salted hash."
  def verify_secret(%Player{secret_salt: salt, secret_hash: stored}, secret)
      when is_binary(secret) do
    const_eq(hash(salt, secret), stored)
  end

  # Constant-time compare: XOR every byte and check the sum is zero, so the
  # first-difference position does not affect running time. Inputs are both
  # 32-byte SHA-256 hashes, so lengths always match.
  defp const_eq(a, b) when is_binary(a) and is_binary(b) do
    if byte_size(a) != byte_size(b) do
      false
    else
      a
      |> :binary.bin_to_list()
      |> Enum.zip(b |> :binary.bin_to_list())
      |> Enum.reduce(0, fn {x, y}, acc -> acc + bxor(x, y) end) == 0
    end
  end

  defp normalize(name), do: String.downcase(String.trim(name || ""))
  defp hash(salt, secret), do: :crypto.hash(:sha256, salt <> secret)
end
