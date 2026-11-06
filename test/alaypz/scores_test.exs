defmodule Alaypz.ScoresTest do
  use Alaypz.DataCase
  @moduletag :repo_sandbox

  alias Alaypz.Players
  alias Alaypz.Scores

  defp filled_board() do
    List.duplicate(List.duplicate(nil, 10), 17) ++
      [
        [nil, :t, nil, :t, nil, :t, nil, :t, nil, :t],
        [:i, :i, :i, :i, nil, nil, nil, nil, :o, :o],
        [:o, :o, :o, :o, nil, nil, nil, nil, nil, nil]
      ]
  end

  defp empty_board() do
    List.duplicate(List.duplicate(nil, 10), 20)
  end

  defp board_string(board \\ filled_board()) do
    Scores.encode_board(board)
  end

  test "board encode/decode round-trips" do
    encoded = board_string()
    assert String.length(encoded) == 200
    assert Scores.decode_board(encoded) == filled_board()
    assert Scores.decode_board(board_string(empty_board())) == empty_board()
  end

  test "record/1 validates input" do
    {:ok, player, _} = Players.claim_name("Validator-Run")

    assert {:error, cs} =
             Scores.record(%{
               player_id: player.id,
               score: -1,
               lines: 0,
               level: 1,
               end_reason: "finished",
               board: board_string()
             })

    assert :score in Keyword.keys(cs.errors)

    assert {:error, cs} =
             Scores.record(%{
               player_id: player.id,
               score: 0,
               lines: 0,
               level: 1,
               end_reason: "abandoned",
               board: board_string()
             })

    assert :end_reason in Keyword.keys(cs.errors)

    assert {:error, cs} =
             Scores.record(%{
               player_id: player.id,
               score: 0,
               lines: 0,
               level: 1,
               end_reason: "finished",
               board: "short"
             })

    assert :board in Keyword.keys(cs.errors)
  end

  test "top 10 ranks by score desc and lists per-player games" do
    {:ok, a, _} = Players.claim_name("Rank-A-Run")
    {:ok, b, _} = Players.claim_name("Rank-B-Run")

    for n <- 1..12 do
      player = if rem(n, 2) == 0, do: a, else: b

      assert {:ok, _} =
               Scores.record(%{
                 player_id: player.id,
                 score: n * 10,
                 lines: n,
                 level: 1,
                 end_reason: if(rem(n, 2) == 0, do: "finished", else: "interrupted"),
                 board: board_string()
               })
    end

    top = Scores.list_top(10)
    assert length(top) == 10

    top_scores = Enum.map(top, & &1.score)
    assert top_scores == Enum.sort(top_scores, &>=/2)
    assert Enum.at(top_scores, 0) == 120
    assert Enum.at(top_scores, 9) == 30
    assert Enum.all?(top, &is_struct(&1.player, Alaypz.Players.Player))

    a_games = Scores.list_for_player(a)
    assert length(a_games) == 6
    assert Enum.map(a_games, & &1.score) == [120, 100, 80, 60, 40, 20]
  end

  test "record stores the final state for later drawing" do
    {:ok, player, _} = Players.claim_name("Draw-A-Run")

    assert {:ok, score} =
             Scores.record(%{
               player_id: player.id,
               score: 420,
               lines: 4,
               level: 2,
               end_reason: "finished",
               board: board_string()
             })

    assert score.player_id == player.id
    assert score.board == board_string()
    assert score.inserted_at != nil
  end
end
