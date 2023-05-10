defmodule PlayerScoresTest do
  use ExUnit.Case, async: true
  alias AflFantasyScraper.PlayerScores.PlayerScores

  # test "scrape_player_scores/0" do
  #   IO.insepct(PlayerScores.scrape_player_scores())
  # end

  test "parse_player/1" do
    header_example =
      {"tr", [],
       [
         {"td", [{"height", "28"}, {"class", "lbnorm"}], ["┬áPlayer"]},
         {"td", [{"class", "lbnorm"}], ["Team"]},
         {"td", [{"class", "bnorm"}, {"width", "90"}], ["Price"]},
         {"td", [{"class", "bnorm"}, {"width", "40"}, {"title", "Games"}], ["G"]},
         {"td", [{"class", "bnorm"}, {"class", "verticalspacing"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('A');getSbyValue('1')"}],
             ["Total"]}
          ]},
         {"td", [{"class", "bnorm"}, {"class", "verticalspacing"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('D');getSbyValue('2')"}],
             ["Average"]}
          ]},
         {"td", [{"class", "bnorm"}, {"class", "verticalspacing"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('D');getSbyValue('3')"}],
             ["3-Rnd Average"]}
          ]},
         {"td", [{"class", "bnorm"}, {"class", "verticalspacing"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('D');getSbyValue('4')"}],
             ["$/Average"]}
          ]},
         {"td", [{"class", "bnorm"}, {"class", "verticalspacing"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('D');getSbyValue('5')"}],
             ["$/3-Rnd Avg"]}
          ]},
         {"td", [{"class", "bnorm"}, {"class", "verticalspacing"}],
          [
            {"span",
             [{"class", "sortByAjaxLink"}, {"onclick", "getOrderByValue('D');getSbyValue('6')"}],
             ["Consistency"]}
          ]}
       ]}

    assert [
             "Player",
             "Position",
             "Team",
             "Price",
             "G",
             "Total",
             "Average",
             "3-Rnd Average",
             "$/Average",
             "$/3-Rnd Avg",
             "Consistency"
           ] = PlayerScores.parse_player(header_example)

    example_player =
      {"tr",
       [
         {"class", "darkcolor"},
         {"onmouseover", "this.className='highlightcolor';"},
         {"onmouseout", "this.className='darkcolor';"}
       ],
       [
         {"td", [{"height", "24"}, {"align", "left"}],
          [
            "┬á",
            {"a", [{"href", "pr-western-bulldogs--timothy-english"}], ["Timothy English"]},
            {"span", [{"class", "playerflag"}], ["RUC"]}
          ]},
         {"td", [{"align", "left"}],
          ["┬á", {"a", [{"href", "th-western-bulldogs"}], ["Bulldogs"]}]},
         {"td", [{"align", "center"}], ["$1,040,000"]},
         {"td", [{"align", "center"}], ["8"]},
         {"td", [{"align", "center"}], ["990"]},
         {"td", [{"align", "center"}], ["123.8"]},
         {"td", [{"align", "center"}], ["126.3"]},
         {"td", [{"align", "center"}], ["$8,401"]},
         {"td", [{"align", "center"}], ["$8,234"]},
         {"td", [{"align", "center"}], ["58"]}
       ]}

    assert [
             "Timothy English",
             "RUC",
             "Bulldogs",
             "$1,040,000",
             "8",
             "990",
             "123.8",
             "126.3",
             "$8,401",
             "$8,234",
             "58"
           ] = PlayerScores.parse_player(example_player)
  end
end
