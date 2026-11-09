defmodule Alaypz.PlayersTest do
  use Alaypz.DataCase
  @moduletag :repo_sandbox

  alias Alaypz.Players

  @alphabet "ABCDEFGHJKMNPQRSTUVWXYZ23456789"

  describe "claim_name/1" do
    test "creates a player with a salted secret and returns the access string" do
      {:ok, player, secret} = Players.claim_name("  Ada  ")

      assert player.name == "Ada"
      assert player.name_key == "ada"
      assert byte_size(player.secret_salt) == 16
      assert byte_size(player.secret_hash) == 32
      assert Players.verify_secret(player, secret)
      refute Players.verify_secret(player, "WRONGSECRETWRONGSECRETWR")
    end

    test "rejects a duplicate name case-insensitively" do
      {:ok, _, _} = Players.claim_name("Nova")

      assert {:error, %Ecto.Changeset{} = cs} = Players.claim_name("nova")
      assert [name: {"has already been taken", _}] = cs.errors
    end

    test "rejects names with internal whitespace" do
      assert {:error, %Ecto.Changeset{} = cs} = Players.claim_name("Too Many")
      assert [name: {"must be a single word", _}] = cs.errors
    end

    test "rejects names over 24 characters" do
      assert {:error, %Ecto.Changeset{}} = Players.claim_name(String.duplicate("a", 25))
    end
  end

  describe "reclaim_name/2" do
    setup do
      {:ok, player, secret} = Players.claim_name("Reclaimer")
      {:ok, player: player, secret: secret}
    end

    test "reclaims with the correct secret, case-insensitively", %{player: player, secret: secret} do
      assert {:ok, got} = Players.reclaim_name("reclaimer", secret)
      assert got.id == player.id
    end

    test "rejects a wrong secret", %{secret: secret} do
      assert {:error, :secret_mismatch} = Players.reclaim_name("Reclaimer", secret <> "0")
    end

    test "unknown name", _ do
      assert {:error, :name_not_found} =
               Players.reclaim_name("Nobody-Here-At-All", "01234567890123456789")
    end
  end

  test "access strings are 20 chars from the unambiguous alphabet" do
    letters = String.graphemes(@alphabet)

    for _ <- 1..5 do
      s = Players.generate_access_string()
      assert String.length(s) == 20
      assert Enum.all?(String.graphemes(s), &(&1 in letters))
    end
  end
end
