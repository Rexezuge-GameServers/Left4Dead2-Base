# Left4Dead2-Base

## Overview

This container (`Base`) serves as the foundational layer for all Left4Dead2 dedicated server image variants, providing shared dependencies and a consistent build environment.

⚠️ This image is not intended to be executed directly. Instead, it provides essential dependencies for upper layers in the build process.

## Executable Variants

The following containers are built on top of `Base` and are designed to be run:

* **Default** (no extension): Standard game server with customer-managed releases and minimal modifications.
* **Full**: Game server with centrally managed full content, including all maps and assets.
* **Full-Slim**: A lighter version of Full, with select assets removed for streamlined deployments.
* **(Experimental) Full-Squash**: Optimized production image with merged layers and fully compressed assets.
* **(Experimental) Full-Slim-Squash**: The most compact production image combining the asset-reduced structure of Full-Slim with layer squashing and compression. Ideal for constrained environments where storage, bandwidth, or startup performance is a critical consideration.

## Intermediate Layers and Asset Variants

These containers are not intended for standalone execution, but provide critical content structure for higher-layer images:

* **StaticAssets**: Primary asset bundle with all required game content.
* **StaticAssets-Unpacked-NoDLC3**: Extracted assets excluding DLC3-specific files. Used as input for content splitting and selective deployment.
* **StaticAssets-Unpacked-DLC3**: Extracted DLC3 content. Separated to allow optional inclusion.
* **StaticAssets-Unpacked-Merged**: Unified structure combining both `StaticAssets-Unpacked-NoDLC3` and `StaticAssets-Unpacked-DLC3`. Acts as the base for all slimmed-down and optimized asset layers.
* **StaticAssets-Slim**: Derived from `StaticAssets-Unpacked-Merged`, it includes only essential content for performance-critical deployments.
* **StaticAssets-Squash**: A squashed variant of `StaticAssets`, consolidating layers to reduce image size.
* **StaticAssets-Slim-Squash**: A compressed and squashed form of `StaticAssets-Slim`.

## Dependency Tree

```text
Base
└── Default (no extension)
    └── StaticAssets
        ├── Full
        ├── StaticAssets-Squash (Deprecated)
        │   └── Full-Squash (Deprecated)
        ├── StaticAssets-Unpacked-NoDLC3 (Deprecated)
        ├── StaticAssets-Unpacked-DLC3 (Deprecated)
        │   └── StaticAssets-Unpacked-Merged (Deprecated)
        │       └── StaticAssets-Slim (Deprecated)
        │           ├── Full-Slim (Deprecated)
        │           └── StaticAssets-Slim-Squash (Deprecated)
        │               └── Full-Slim-Squash (Deprecated)
```

## Weekly Build Schedule

Builds are executed on a fixed weekly cycle to ensure consistency and allow time for testing and validation across the stack:

| Day       | Build Targets                                                                                     |
|-----------|---------------------------------------------------------------------------------------------------|
| Monday    | `Base`, `Full-Slim-Squash` (previous cycle)                                                       |
| Tuesday   | `Default`                                                                                         |
| Wednesday | `StaticAssets`                                                                                    |
| Thursday  | `Full`, `StaticAssets-Unpacked-NoDLC3`, `StaticAssets-Unpacked-DLC3`                              |
| Friday    | `StaticAssets-Unpacked-Merged`                                                                    |
| Saturday  | `StaticAssets-Slim`                                                                               |
| Sunday    | `Full-Slim`, `StaticAssets-Slim-Squash`                                                           |
