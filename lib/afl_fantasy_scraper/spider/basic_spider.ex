defmodule AflFantasyScraper.BasicSpider do
  use Crawly.Spider
  @impl Crawly.Spider
  def base_url do
    "https://www.footywire.com"
  end

  @impl Crawly.Spider
  def init() do
    [
      start_urls: [
        "https://www.footywire.com/afl/footy/dream_team_breakevens?p=&min_salary=0&max_salary=1500000&sort=1&order=A"
      ]
    ]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} =
      response.body
      |> Floki.parse_document()

    tables =
      document
      |> Floki.find("#fantasy-break-even-div")
      |> Floki.text(sep: ",")

    %Crawly.ParsedItem{
      :items => [
        %{tables: tables, url: response.request_url}
      ],
      :requests => []
    }

    File.write(".\\test.txt", tables)
  end
end

Run
