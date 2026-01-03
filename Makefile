SHELL := /bin/bash

.PHONY: help
help:
	@echo "Targets:"
	@echo "  make check    - verify linux + docker + compose"
	@echo "  make env      - create .env from .env.example (safe copy)"
	@echo "  make tree     - show folder structure (basic)"
	@echo "  make up       - docker compose up (works after Phase 2)"
	@echo "  make down     - docker compose down (works after Phase 2)"

.PHONY: check
check:
	@echo "== Linux =="
	@uname -a
	@echo
	@echo "== Docker CLI =="
	@docker version || true
	@echo
	@echo "== Docker Compose =="
	@docker compose version || true

.PHONY: env
env:
	@test -f .env || cp .env.example .env
	@echo "Created .env (if it didn't exist). Now edit .env and set FRED_API_KEY."

.PHONY: tree
tree:
	@find . -maxdepth 3 -type d | sed 's|^\./||' | sort

.PHONY: up
up:
	docker compose up --build

.PHONY: down
down:
	docker compose down -v
