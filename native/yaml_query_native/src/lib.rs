#[rustler::nif]
fn query(yaml: &str, jql_query: &str) -> Result<String, String> {
    let map: serde_json::Value = serde_yaml::from_str(&yaml).map_err(|e| e.to_string())?;
    let output = jql_runner::runner::raw(jql_query, &map).map_err(|e| e.to_string())?;
    let encoded_out = serde_yaml::to_string(&output).map_err(|e| e.to_string())?;
    Ok(encoded_out.trim().to_string())
}

rustler::init!("Elixir.YamlQuery.Native", [query]);
