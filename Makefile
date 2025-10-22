.PHONY: help install install-dev test lint format clean docker-up docker-down docker-logs

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install production dependencies
	uv sync --no-dev

install-dev: ## Install development dependencies
	uv sync

test: ## Run tests
	uv run pytest

test-cov: ## Run tests with coverage
	uv run pytest --cov=inventory_management --cov-report=html --cov-report=term

lint: ## Run linting
	uv run ruff check inventory_management/

format: ## Format code
	uv run ruff format inventory_management/
	uv run ruff check --fix inventory_management/

format-check: ## Check code formatting
	uv run ruff format --check inventory_management/
	uv run ruff check inventory_management/

clean: ## Clean up temporary files
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	rm -rf build/
	rm -rf dist/
	rm -rf .coverage
	rm -rf htmlcov/
	rm -rf .pytest_cache/

docker-up: ## Start Docker services
	docker compose up -d

docker-down: ## Stop Docker services
	docker compose down

docker-logs: ## Show Docker logs
	docker compose logs -f

docker-reset: ## Reset Docker services (removes data)
	docker compose down -v
	docker compose up -d

setup: install-dev docker-up ## Initial setup
	@echo "Setup complete! Run 'make docker-up' to start services."

pre-commit: ## Install pre-commit hooks
	uv run pre-commit install

pre-commit-run: ## Run pre-commit on all files
	uv run pre-commit run --all-files

run-dev: ## Start development server
	uv run python -m inventory_management.main

migrate-create: ## Create a new migration
	uv run alembic revision --autogenerate -m "$(message)"

migrate-upgrade: ## Upgrade the database
	uv run alembic upgrade head

migrate-downgrade: ## Downgrade the database
	uv run alembic downgrade -1

migrate-history: ## Show the migration history
	uv run alembic history
