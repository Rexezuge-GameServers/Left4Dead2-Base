# Left4Dead2-Base

## Overview

This container (`Base`) serves as the foundational layer for all Left4Dead2 dedicated server image variants, providing shared dependencies and a consistent build environment.

⚠️ This image is not intended to be executed directly. Instead, it provides essential dependencies for upper layers in the build process.

## Executable Variants

The following containers are built on top of `Base` and are designed to be run:

* Default (no extension): Standard game server with customer-managed releases and minimal modifications.
* Full: Game server with centrally managed full content, including all maps and assets.
* Full-Slim: A lighter version of Full, with select assets removed for streamlined deployments.
* (Experimental) Full-Squash: Optimized production image with merged layers and full compressed assets.
* (Experimental) Full-Slim-Squash: The most compact production image combining the asset-reduced structure of Full-Slim with layer squashing and compression. Ideal for constrained environments where storage, bandwidth, or startup performance is a critical consideration.

## Dependency Tree

```text
Base
 └── Default (no extension)
      └── StaticAssets
           ├── StaticAssets-Squash
           │     └── Full-Squash
           ├── Full
           └── StaticAssets-Slim
                 ├── Full-Slim
                 └── StaticAssets-Slim-Squash
                       └── Full-Slim-Squash
```

## Weekly Build Schedule

Builds are executed on a fixed weekly cycle to ensure consistency and allow time for testing and validation across the stack:

| Day          | Build Targets                                          |
| ------------ | ------------------------------------------------------ |
| Monday       | `Base`                                                 |
| Tuesday      | `Default`                                              |
| Wednesday    | `StaticAssets`                                         |
| Thursday     | `StaticAssets-Squash`, `StaticAssets-Slim`, `Full`     |
| Friday       | `Full-Squash`, `Full-Slim`, `StaticAssets-Slim-Squash` |
| Saturday     | `Full-Slim-Squash`                                     |
