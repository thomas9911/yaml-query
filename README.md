# YamlQuery

YamlQuery provides a simple way to execute JQL queries on yaml files.

See https://github.com/yamafaktory/jql for documentation on jql syntax.

## Functions

### from_file(path, query)

@spec from_file(path :: binary(), query :: binary()) ::
{:ok, term()} | {:error, atom() | binary()}

Execute a jql query on the given yaml file.

### query(yaml, query)

@spec query(yaml :: binary(), query :: binary() | charlist()) ::
{:ok, term()} | {:error, binary()}

Execute a jql query on the given yaml string.

```elixir
yaml = """

test:

  nested: 'test'

"""

YamlQuery.query(yaml, ~S|"test""nested"|)
{:ok, "test"}
```

Also support for single quotes, so bash queries can be copied over.

```elixir
yaml = """

test:

  nested: 'test'

"""

YamlQuery.query(yaml, '"test""nested"')
{:ok, "test"}
```
