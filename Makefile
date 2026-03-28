SHELL := /bin/bash

up:
	docker compose up -d --build

down:
	docker compose down

restart:
	docker compose down
	docker compose up -d --build

logs:
	docker compose logs -f

ps:
	docker compose ps

bash-api:
	docker compose exec api bash

bash-front:
	docker compose exec front sh

console:
	docker compose exec api php bin/console

composer:
	docker compose exec api composer

npm:
	docker compose exec front npm

db-shell:
	docker compose exec db psql -U $$POSTGRES_USER -d $$POSTGRES_DB

entity:
	docker compose exec api php bin/console make:entity

migration:
	docker compose exec api php bin/console make:migration

migrate:
	docker compose exec api php bin/console doctrine:migrations:migrate