defmodule AflFantasyScraper.CleanFile do
  def process_file(input_file, output_file) do
    with {:ok, content} <- File.read(input_file),
         {:ok, processed_content} <- process_content(content) do
      File.write(output_file, processed_content)
    end
  end

  defp process_content(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&process_line/1)
    |> Enum.join("\n")

    {:ok, content}
  end

  defp process_line(line) do
    line
    |> String.split("\t")
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      cond do
        rem(index + 1, 7) == 0 -> value <> "\n"
        true -> value <> "\t"
      end
    end)
    |> IO.puts()
    |> Enum.join("")
  end
end
