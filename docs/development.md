# Development Guide

## Prerequisites

- [pyenv](https://github.com/pyenv/pyenv#installation)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- [Commitizen](https://commitizen-tools.github.io/commitizen/#installation)
- [Poetry](https://python-poetry.org/docs/#installation)

## Install Dependencies

1. Install Python dependencies.

    ```bash
    poetry install --with dev
    ```

1. Install pre commit hooks.

    ```bash
    poetry run pre-commit install
    ```

## Toolings

- Python
  - Python version manager: [pyenv](https://github.com/pyenv/pyenv#installation)
  - Python dependency manager: [Poetry](https://python-poetry.org/docs/#installation)
  - Code formatter: [black](https://github.com/psf/black)
  - Code linting: [pylint](https://github.com/PyCQA/pylint), [flake8](https://github.com/PyCQA/flake8)

- Development
  - IDE: [VS Code](https://code.visualstudio.com/)
  - Pre-commit hooks: [pre-commit](https://pre-commit.com/)
  - Commit standard: [Commitizen](https://commitizen-tools.github.io/commitizen/#installation)
