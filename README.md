# Left4Dead2-Base

## Overview

This container (`Base`) serves as the foundational layer for all Left4Dead2 dedicated server image variants, providing shared dependencies and a consistent build environment.

⚠️ This image is not intended to be executed directly. Instead, it provides essential dependencies for upper layers in the build process.

## Executable Variants

The following containers are built on top of `Base` and are designed to be run:

* Default (no extension): Standard game server with customer-managed releases and minimal modifications.
* Full: Game server with centrally managed full content, including all maps and assets.
* Full-Squash: Optimized production image with merged layers and full compressed assets.
* Full-Slim: A lighter version of Full, with select assets removed for streamlined deployments.

## Dependency Tree

```text
Base
 └── Default (no extension)
      └── StaticAssets
           ├── StaticAssets-Squash
           │     └── Full-Squash
           ├── Full
           └── StaticAssets-Slim
                 └── Full-Slim
```

## Weekly Build Schedule

Builds are executed on a fixed weekly cycle to ensure consistency and allow time for testing and validation across the stack:

* Monday: Build Base
* Tuesday: Compile Default
* Wednesday: Compile StaticAssets
* Thursday: Compile StaticAssets-Squash, StaticAssets-Slim, and Full
* Friday: Compile Full-Squash and Full-Slim
