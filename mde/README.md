# Manufacturing Data Engine Configurations

This folder contains Manufacturing Data Engine (MDE) configurations
expressed in JSON for configuring MDE deployment. The subfolders
contain specific type of MDE configurations:

| Folder | MDE Configuration |
|--------|------------------------|
| buckets | Metadata buckets |
| ingestions | Ingestion specifications |
| metadata_instances | Metadata instances per tag |
| parsers | Parsers |
| payloads | Payloads |
| schema_to_buckets | Relationships of metadata schemas to metadata buckets |
| schemas | Metadata schemas |
| tags | Tags |
| types | Data types |

## Usage

You can use [configure_mde.sh](./configure_mde.sh) to configure your MDE
deployment. Example:

```bash
export MDE_CONFIG_MANAGER_URL="http://localhost" # format: 'http://<ip-or-dns>'
export MDE_CONFIG_MANAGER_PORT="8080" # format: [0-65536]

./configure_mde.sh --url "${MDE_CONFIG_MANAGER_URL}" \
    --port "${MDE_CONFIG_MANAGER_PORT}"
```

## Gotcha

It is possible that the priority of the
[tool_wear_predictions payload](./payloads/tool_wear_predictions.json)
may conflict with your existing payloads. If a conflict occurs, you will
receive a `400 Bad Request` response:

```json
{
    "status": 400,
    "message": "Invalid value",
    "debugMessage": "This priority is already used with one of the existing payloads. The nearest value you can choose is 32449 – ",
}
```

To resolve the priority conflict, you can modify the priority value of the
[tool_wear_predictions payload](./payloads/tool_wear_predictions.json)
to the value suggested by MDE.
