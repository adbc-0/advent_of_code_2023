defmodule AdventOfCode.Trebuchet do
  @moduledoc """
  Solve trebuchet problem.
  """

  @numbersMap %{one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9}

  defp remove_letters(v) do
    String.replace(v, ~r/\D/, "")
  end

  defp decode_integers(s) do
    @numbersMap
    |> Enum.reduce(s, fn {word, number}, s ->
      String.replace(s, "#{word}", "#{word}#{number}#{word}", global: true)
    end)
  end

  defp find_integer(v) do
    case String.length(v) do
      0 -> 0
      1 -> parse_number("#{v}#{v}")
      _ -> parse_number("#{String.first(v)}#{String.last(v)}")
    end
  end

  defp parse_number(v) do
    case Integer.parse(v) do
      {num, ""} -> num
      _ -> raise ArgumentError, message: "Invalid input: #{v}"
    end
  end

  defp recover_numeric_calibration_values(calibration_values) do
    calibration_values
    |> Enum.map(&remove_letters/1)
    |> Enum.map(&find_integer/1)
    |> Enum.sum()
  end

  defp recover_string_calibration_values(calibration_values) do
    calibration_values
    |> Enum.map(&decode_integers/1)
    |> recover_numeric_calibration_values()
  end

  def solve do
    input = FileReader.read_content("trebuchet")

    numeric_solution = recover_numeric_calibration_values(input)
    IO.puts(numeric_solution)

    string_solution = recover_string_calibration_values(input)
    IO.puts(string_solution)
  end
end
