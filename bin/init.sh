#!/usr/bin/env bash
set -euo pipefail

SLUG="${1:-}"

if [ -z "$SLUG" ]; then
  echo "Usage: ./bin/init <slug>"
  exit 1
fi

if [ ! -f .env ]; then
  cp .env.example .env
fi

DB_PORT=$((20000 + ($(echo -n "$SLUG" | cksum | cut -d' ' -f1) % 20000)))

sed -i.bak "s/^PROJECT_SLUG=.*/PROJECT_SLUG=${SLUG}/" .env
sed -i.bak "s/^COMPOSE_PROJECT_NAME=.*/COMPOSE_PROJECT_NAME=${SLUG}/" .env
sed -i.bak "s/^APP_DOMAIN=.*/APP_DOMAIN=${SLUG}.localhost/" .env
sed -i.bak "s/^API_DOMAIN=.*/API_DOMAIN=api.${SLUG}.localhost/" .env
sed -i.bak "s/^DB_DOMAIN=.*/DB_DOMAIN=db.${SLUG}.localhost/" .env
sed -i.bak "s/^DB_PORT=.*/DB_PORT=${DB_PORT}/" .env
sed -i.bak "s|^NUXT_PUBLIC_API_BASE=.*|NUXT_PUBLIC_API_BASE=https://api.${SLUG}.localhost|" .env

rm -f .env.bak

docker network inspect proxy >/dev/null 2>&1 || docker network create proxy

docker compose up -d --build

echo ""
echo "Projet prêt :"
echo "  Front : https://${SLUG}.localhost"
echo "  API   : https://api.${SLUG}.localhost"
echo "  DB    : host=db.${SLUG}.localhost port=${DB_PORT}"