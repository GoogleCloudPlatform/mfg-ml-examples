# Manufacturing Connect edge Configurations

This folder contains Manufacturing Connect edge (MCe) configurations
expressed in JSON for configuring MCe. The subfolders
contain specific type of MCe configurations:

| Folder | MCe Configuration |
|--------|-------------------|
| connectors | Integration connectors |
| flows | Flows |

## Usage

You can use [configure_mce.sh](./configure_mce.sh) to configure your MCe.
Example:

```bash
export MCE_URL="https://localhost" # format: 'https://<ip-or-dns>'
export MCE_API_TOKEN="aGVsbG93b3JsZDo=" # base64 encoded MCe API key + ':'
export MCE_PUBSUB_CONNECTOR_ID="11111111-aaaa-2222-bbbb-333333333333" # MCe pub/sub connector id

./configure_mce.sh --url "${MCE_URL}" \
    --token "${MCE_API_TOKEN}" \
    --connector "${MCE_PUBSUB_CONNECTOR_ID}"
```
