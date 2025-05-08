# Left4Dead2-Base

## Overview

This container (`Base`) serves as the foundational layer for all Left4Dead2 dedicated server image variants, providing shared dependencies and a consistent build environment.

**It is not intended to be executed directly**. Instead, it provides essential dependencies for upper layers in the build process.

## Execution Notes

While the `Base` container itself is not runnable, the following target containers built on top of it **can be executed**:

- `Default (no extension)`: The standard asset layer without any compression or post-processing.
- `Full`: The full version of the static assets, uncompressed.
- `Full-Squash`: A compressed and merged version optimized for production deployment.

## Dependency Tree

```text
Base
 └── Default (no extension)
      └── StaticAssets
           ├── StaticAssets-Squash
           │     └── Full-Squash
           └── Full
```

## Weekly Build Schedule

To ensure consistent and reliable output, builds are executed according to the following weekly schedule:

* **Monday**: Build `Base`
* **Tuesday**: Compile `Default`
* **Wednesday**: Compile `StaticAssets`
* **Thursday**: Compile `StaticAssets-Squash` and `Full`
* **Friday**: Compile `Full-Squash`
