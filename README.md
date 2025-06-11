# Valkey-Fly

This Docker image for Valkey is specifically tailored for deployment on Fly.io, incorporating features from the official Valkey image while ensuring operation in LTS (Long-Term Support) mode. It uniquely facilitates the integration of Valkey configuration settings directly from environment variables and includes the option to activate swap space on Fly.io.

## Configurable Environment Variables

The image recognizes and utilizes a set of environment variables for customization:

- `VALKEY_PORT`: Specifies the port for TLS connections, with a default setting of `6379`.
- `VALKEY_PASSWORD`: Mandatory for setting the authentication password.
- `VALKEY_DATA_DIR`: Optional directory where data is stored
- `EXTRA_VALKEY_CONFIG`: Allows the inclusion of additional Valkey configuration settings. By default, no extra configurations are added.
- `SWAP`: Controls the activation of swap space, not enabled by default.
- `SWAP_SIZE`: Defines the size of the swap space, should it be enabled, with a default of `512M`.
