# Redis-Fly

This Docker image for Redis is specifically tailored for deployment on Fly.io, incorporating features from the official Redis image while ensuring operation in LTS (Long-Term Support) mode. It uniquely facilitates the integration of Redis configuration settings directly from environment variables and includes the option to activate swap space on Fly.io.

## Configurable Environment Variables

The image recognizes and utilizes a set of environment variables for customization:

- `REDIS_PORT`: Specifies the port for TLS connections, with a default setting of `6379`.
- `REDIS_PASSWORD`: Mandatory for setting the authentication password.
- `EXTRA_REDIS_CONFIG`: Allows the inclusion of additional Redis configuration settings. By default, no extra configurations are added.
- `SWAP`: Controls the activation of swap space, not enabled by default.
- `SWAP_SIZE`: Defines the size of the swap space, should it be enabled, with a default of `512M`.
