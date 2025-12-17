#!/usr/bin/env bash

poetry run alembic upgrade head
poetry run fastapi run src/todos/main.py
