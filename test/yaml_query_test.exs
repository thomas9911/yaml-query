defmodule YamlQueryTest do
  use ExUnit.Case
  doctest YamlQuery

  test "simple" do
    yaml = """
    test:
      nested: 'test'
    """

    assert {:ok, "test"} = YamlQuery.query(yaml, ~S|"test""nested"|)
  end

  test "charlist" do
    yaml = """
    test:
      nested: 'test'
    """

    assert {:ok, "test"} = YamlQuery.query(yaml, '"test""nested"')
  end

  @tag :tmp_dir
  test "from file", %{tmp_dir: tmp_dir} do
    yaml = """
    test:
      nested: 'test from file'
    """

    file = Path.join([tmp_dir, "input.yaml"])

    File.write!(file, yaml)

    assert {:ok, "test from file"} = YamlQuery.from_file(file, ~S|"test""nested"|)
  end
end
