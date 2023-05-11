defmodule AflFantasyScraper.BreakEvens.BreakEvens do
  def scrape_be() do
    base_url = "https://www.footywire.com/afl/footy/dream_team_breakevens"

    with {:ok, response} <- Req.get(base_url),
         {:ok, document} <- Floki.parse_document(response.body) do
      tables = Floki.find(document, "#fantasy-break-even-div")
      fantasy_table = Floki.find(tables, "table tr")
      parsed_fantasy_table = fantasy_table |> Enum.map(&parse_row/1)
      {:ok, parsed_fantasy_table}
    else
      error -> {:error, error}
    end
  end

  def parse_row(
        {"tr", _,
         [
           {"td", [_, _], [player]},
           {"td", [_, _], [team]},
           {"td", [_, _], [price]},
           {"td", [_, _, _], [games]},
           {"td", [_, _], [{_, [_, _], [average]}]},
           {"td", [_, _], [{_, [_, _], [breakeven]}]},
           {"td", [_, _], [{_, [_, _], [likelihood]}]}
         ]}
      ) do
    [player, "Position", team, price, games, average, breakeven, likelihood]
    |> Enum.map(&String.trim/1)

    %{
      :player => player,
      :position => "Position",
      :team => team,
      :price => price,
      :games => games,
      :avg => average,
      :breakeven => breakeven,
      :likelihood => likelihood
    }
  end

  def parse_row(
        {"tr", _,
         [
           {"td", _, [_, {_, _, [name]}, {_, _, [position]}]},
           {"td", _, [{_, _, [team]}]},
           {"td", _, [price]},
           {"td", _, [games]},
           {"td", _, [average]},
           {"td", _, [breakeven]},
           {"td", _, [likelihood]}
         ]}
      ) do
    [name, position, team, price, games, average, breakeven, likelihood]
    |> Enum.map(&String.trim/1)

    %{
      :player => name,
      :position => position,
      :team => team,
      :price => price,
      :games => games,
      :avg => average,
      :breakeven => breakeven,
      :likelihood => likelihood
    }
  end
end
