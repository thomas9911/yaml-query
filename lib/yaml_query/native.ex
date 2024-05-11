defmodule YamlQuery.Native do
  @moduledoc false
  use Rustler, otp_app: :yaml_query, crate: "yaml_query_native"

  # When your NIF is loaded, it will override this function.
  def query(_yaml, _query), do: :erlang.nif_error(:nif_not_loaded)
end
