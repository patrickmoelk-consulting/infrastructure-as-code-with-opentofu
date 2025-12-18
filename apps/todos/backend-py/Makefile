.PHONY: run-dev
run-dev:
	poetry run dotenv run fastapi dev src/todos/main.py

.PHONY: migrations-generate
migrations-generate:
	echo "Enter migration message:"; read migration_name; echo $$migration_name > migration_name.txt
	set -a; source .env; set +a; poetry run alembic revision --autogenerate -m "$$(cat migration_name.txt)"
	rm migration_name.txt

.PHONY: migrations-run-local
migrations-run-local:
	poetry run dotenv run alembic upgrade head
