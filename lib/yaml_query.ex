defmodule YamlQuery do
  @moduledoc """
  YamlQuery provides a simple way to execute JQL queries on yaml files.

  See https://github.com/yamafaktory/jql for documentation on jql syntax.
  """

  @doc """
  Execute a jql query on the given yaml file.
  """
  @spec from_file(path :: binary, query :: binary) :: {:ok, term} | {:error, atom | binary}
  def from_file(path, query) do
    case File.read(path) do
      {:ok, content} ->
        query(content, query)

      error ->
        error
    end
  end

  @doc """
  Execute a jql query on the given yaml string.

  ```elixir
  iex> yaml = \"""
  ...> test:
  ...>   nested: 'test'
  ...> \"""
  iex> YamlQuery.query(yaml, ~S|"test""nested"|)
  {:ok, "test"}
  ```

  Also support for single quotes, so bash queries can be copied over.

  ```elixir
  iex> yaml = \"""
  ...> test:
  ...>   nested: 'test'
  ...> \"""
  iex> YamlQuery.query(yaml, '"test""nested"')
  {:ok, "test"}
  ```
  """
  @spec query(yaml :: binary, query :: binary | charlist()) :: {:ok, term} | {:error, binary}
  def query(yaml, query) when is_list(query) do
    query(yaml, List.to_string(query))
  end

  defdelegate query(yaml, query), to: YamlQuery.Native
end
