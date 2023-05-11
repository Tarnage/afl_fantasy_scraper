defmodule AflFantasyScraper.PlayerScores.PlayerScores do
  def scrape_player_scores do
    base_url = "https://www.footywire.com/afl/footy/dream_team_scores"

    with {:ok, response} <- Req.get(base_url),
         {:ok, document} <- Floki.parse_document(response.body) do
      tables = Floki.find(document, "#fantasy-scores-div")
      player_table = Floki.find(tables, "table tr")
      parsed_palyer_table = player_table |> Enum.map(&parse_player/1)
      {:ok, parsed_palyer_table}
    else
      error -> {:error, error}
    end
  end

  def parse_player(
        {"tr", _,
         [
           {"td", _, [_]},
           {"td", _, [team]},
           {"td", _, [price]},
           {"td", _, [games]},
           {"td", _, [{_, _, [total]}]},
           {"td", _, [{_, _, [avg]}]},
           {"td", _, [{_, _, [avg_3_rnd]}]},
           {"td", _, [{_, _, [dollar_avg]}]},
           {"td", _, [{_, _, [avg_3_rnd_dollar]}]},
           {"td", _, [{_, _, [consistency]}]}
         ]}
      ) do
    [
      "Player",
      "Position",
      team,
      price,
      games,
      total,
      avg,
      avg_3_rnd,
      dollar_avg,
      avg_3_rnd_dollar,
      consistency
    ]
    |> Enum.map(&String.trim/1)

    %{
      :player => "Player",
      :position => "Position",
      :team => team,
      :price => price,
      :games => games,
      :total => total,
      :avg => avg,
      :three_rnd_avg => avg_3_rnd,
      :dollar_avg => dollar_avg,
      :dollar_three_rnd_avg => avg_3_rnd_dollar,
      :consistency => consistency
    }
  end

  def parse_player(
        {"tr", _,
         [
           {"td", _, [_, {_, _, [name]}, {_, _, [position]}]},
           {"td", _, [_, {_, _, [team]}]},
           {"td", _, [price]},
           {"td", _, [games]},
           {"td", _, [total]},
           {"td", _, [avg]},
           {"td", _, [avg_3_rnd]},
           {"td", _, [dollar_avg]},
           {"td", _, [avg_3_rnd_dollar]},
           {"td", _, [consistency]}
         ]}
      ) do
    [
      name,
      position,
      team,
      price,
      games,
      total,
      avg,
      avg_3_rnd,
      dollar_avg,
      avg_3_rnd_dollar,
      consistency
    ]
    |> Enum.map(&String.trim/1)

    %{
      :player => name,
      :position => position,
      :team => team,
      :price => price,
      :games => games,
      :total => total,
      :avg => avg,
      :three_rnd_avg => avg_3_rnd,
      :dollar_avg => dollar_avg,
      :dollar_three_rnd_avg => avg_3_rnd_dollar,
      :consistency => consistency
    }
  end
end
