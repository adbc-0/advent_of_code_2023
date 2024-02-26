defmodule FileReader do
  @spec read_content(String.t()) :: [String.t()]
  def read_content(file_name) do
    contents = File.read!("input_data/#{file_name}")
    lines = String.split(contents, "\n", trim: true)
    lines
  end
end
