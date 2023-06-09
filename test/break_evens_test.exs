defmodule AflFantasyScraperTest.BreakEvensTest do
  use ExUnit.Case, async: true
  alias AflFantasyScraper.BreakEvens.BreakEvens

  # setup do
  #   response = ScrapeBreakevens.scrape_be()

  #   [response: response]
  # end

  test "header parse_row/1" do
    header_example =
      {"tr", [],
       [
         {"td", [{"height", "28"}, {"class", "lbnorm"}], [" Player"]},
         {"td", [{"class", "lbnorm"}, {"width", "85"}], ["Team"]},
         {"td", [{"class", "bnorm"}, {"width", "95"}], ["Price"]},
         {"td", [{"class", "bnorm"}, {"title", "Games"}, {"width", "50"}], ["G"]},
         {"td", [{"class", "bnorm"}, {"width", "60"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('D');getSbyValue(3)"}],
             ["Avg"]}
          ]},
         {"td", [{"class", "bnorm"}, {"width", "95"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('A');getSbyValue(1)"}],
             ["Breakeven"]}
          ]},
         {"td", [{"class", "bnorm"}, {"width", "100"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('D');getSbyValue(2)"}],
             ["Likelihood %"]}
          ]}
       ]}

    assert %{
             avg: "Avg",
             breakeven: "Breakeven",
             games: "G",
             likelihood: "Likelihood %",
             player: " Player",
             position: "Position",
             price: "Price",
             team: "Team"
           } = BreakEvens.parse_row(header_example)
  end

  test "td parse_row/1" do
    td_example =
      {"tr",
       [
         {"class", "darkcolor"},
         {"onmouseover", "this.className='highlightcolor';"},
         {"onmouseout", "this.className='darkcolor';"}
       ],
       [
         {"td", [{"height", "24"}, {"align", "left"}],
          [
            " ",
            {"a", [{"href", "pr-melbourne-demons--max-gawn"}], ["M. Gawn"]},
            {"span", [{"class", "playerflag"}], ["RUC"]}
          ]},
         {"td", [{"align", "left"}], [{"a", [{"href", "th-melbourne-demons"}], ["Demons"]}]},
         {"td", [{"align", "center"}], ["$849,000"]},
         {"td", [{"align", "center"}], ["2"]},
         {"td", [{"align", "center"}], ["58.5"]},
         {"td", [{"align", "center"}], ["171"]},
         {"td", [{"align", "center"}], ["26%"]}
       ]}

    assert %{
             avg: "58.5",
             breakeven: "171",
             games: "2",
             likelihood: "26%",
             player: "M. Gawn",
             position: "RUC",
             price: "$849,000",
             team: "Demons"
           } = BreakEvens.parse_row(td_example)
  end
end
