# GitHub Actions runner with Conda

GitHub Actions runner with Conda pre-installed (using Miniforge version Mambaforge)

The image published on [ghcr.io](https://ghcr.io) is automatically updated every week (Monday at 3:00 GMT+1) by a GitHub Actions workflow to match the `latest` tag of https://github.com/redhat-actions/openshift-actions-runners

## Build

We download the latest miniforge (mambaforge) conda version from GitHub releases, checkout https://github.com/conda-forge/miniforge/releases

Build:

```bash
docker build -t ghcr.io/vemonet/github-actions-conda-runner:latest .
```

## Quick try

```bash
docker run -it --entrypoint=bash ghcr.io/vemonet/github-actions-conda-runner:latest
```

## Push

```bash
docker push ghcr.io/vemonet/github-actions-conda-runner:latest
```
