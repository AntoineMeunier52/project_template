# Fullstack Local Template

Starter template for my **Nuxt + Symfony + API Platform + FrankenPHP + PostgreSQL** projects in local development, with **HTTPS**, **Docker**, **Traefik**, and **multi-project support**.

---

## Why this project exists

I got tired of recreating my projects manually every time:

- creating a new Nuxt project
- creating a new Symfony / API Platform project
- setting Docker up again
- configuring FrankenPHP again
- setting up local HTTPS again
- reconfiguring local dev domains
- dealing with port conflicts

So I built this template as a **local starter platform** to automate my fullstack project setup.

The idea is simple:

- duplicate this template repository
- clone it
- run one command
- start coding immediately

---

## Stack

- Frontend: Nuxt
- Backend: Symfony + API Platform
- PHP server: FrankenPHP
- Database: PostgreSQL
- Proxy: Traefik
- Certificates: mkcert
- Containerization: Docker / Docker Compose

---

## Requirements

Make sure you have:

- Docker
- Docker Compose
- mkcert
- Git

---

## First-time setup (HTTPS)

Only once per machine.

### 1. Create Docker network

```bash
docker network create proxy 2>/dev/null || true
```

### 2. Install mkcert

```bash
mkcert -install
```

### 3. Generate certificates

```bash
mkdir -p docker/traefik/certs
mkcert -cert-file docker/traefik/certs/local.pem -key-file docker/traefik/certs/local-key.pem localhost "*.localhost"
```

### 4. Start Traefik

```bash
docker compose -f docker/traefik/compose.yaml up -d
```

---

## Create a new project

### 1. Clone your new repo

```bash
git clone git@github.com:your-account/project.git
cd project
```

### 2. Make scripts executable

```bash
chmod +x bin/init bin/console bin/composer bin/npm
```

### 3. Initialize project

```bash
./bin/init <new_project>
```

---

## What happens

This command:

- creates `.env`
- sets domains
- generates DB port
- starts Docker

---

## URLs

For slug `new-project`:

- Front: https://new-project.localhost
- API: https://api.new-project.localhost

---

## Database (PhpStorm)

- Host: db.muscu.localhost
- Port: shown after init
- DB: app
- User: app
- Password: app

---

## Useful commands

### Docker

```bash
make up
make down
make restart
make logs
```

### Symfony

```bash
./bin/console make:entity
./bin/console make:migration
./bin/console doctrine:migrations:migrate
./bin/composer require vendor/package
```

### Nuxt

```bash
./bin/npm install
```

---

## How it works

- Traefik handles HTTPS and routing
- FrankenPHP serves Symfony internally
- Nuxt runs in dev mode with hot reload
- PostgreSQL runs in its own container

---

## Multi-project support

You can run multiple projects:

```bash
./bin/init project1
./bin/init project2
```

Result:

- https://project1.localhost
- https://api.project1.localhost
- https://project2.localhost
- https://api.project2.localhost

---

## Philosophy

This is not a generic starter.

This is **my own base stack**, including:

- Nuxt base structure
- Symfony config
- custom generators
- personal conventions

The goal is simple:

> stop wasting time creating projects from scratch.

---

## Summary

Duplicate → init → code.

---

## Future improvements

- Redis
- Typesense
- ClickHouse
- Auth system
- CI/CD

---