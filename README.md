# Inventory Management System

A Python-based inventory management system with PostgreSQL, Redis, and Docker Compose setup.

## Quick Start

1. **Copy the environment file:**

   ```bash
   cp env.example .env
   ```

2. **Install dependencies with uv:**

   ```bash
   uv sync
   ```

3. **Start the services:**

   ```bash
   make docker-up
   ```

4. **Check if services are running:**

   ```bash
   docker-compose ps
   ```

5. **Connect to the database:**
   ```bash
   docker-compose exec postgres psql -U inventory_user -d inventory_db
   ```

## Technology Stack

- **Python 3.11+** with uv package manager
- **FastAPI** for the web framework
- **PostgreSQL 16** for the database
- **Redis 7** for caching and session storage
- **SQLAlchemy** for ORM
- **Alembic** for database migrations
- **Docker Compose** for local development

## Development Setup

1. **Install uv (if not already installed):**

   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

2. **Install dependencies:**

   ```bash
   make install-dev
   ```

3. **Install pre-commit hooks:**

   ```bash
   make pre-commit
   ```

4. **Start services:**
   ```bash
   make docker-up
   ```

## Available Commands

Run `make help` to see all available commands:

- `make install` - Install production dependencies
- `make install-dev` - Install development dependencies
- `make test` - Run tests
- `make test-cov` - Run tests with coverage
- `make lint` - Run linting
- `make format` - Format code
- `make docker-up` - Start Docker services
- `make docker-down` - Stop Docker services
- `make docker-logs` - Show Docker logs
- `make clean` - Clean up temporary files

## Database Schema

The initialization script (`init-sql.sql`) creates the following tables:

- **categories**: Product categories
- **products**: Product inventory with stock levels
- **suppliers**: Supplier information
- **stock_movements**: Track inventory movements (IN/OUT/ADJUSTMENT)

## Environment Variables

You can customize the configuration by modifying the `.env` file:

### Database Configuration

- `POSTGRES_DB`: Database name (default: inventory_db)
- `POSTGRES_USER`: Database user (default: inventory_user)
- `POSTGRES_PASSWORD`: Database password (default: inventory_password)
- `POSTGRES_PORT`: Port mapping (default: 5432)

### Redis Configuration

- `REDIS_HOST`: Redis host (default: localhost)
- `REDIS_PORT`: Redis port (default: 6379)
- `REDIS_PASSWORD`: Redis password (optional)
- `REDIS_DB`: Redis database number (default: 0)

### Application Configuration

- `APP_NAME`: Application name
- `APP_VERSION`: Application version
- `DEBUG`: Debug mode (True/False)
- `SECRET_KEY`: Secret key for JWT tokens

## Database Features

- UUID primary keys for all tables
- Automatic timestamps (created_at, updated_at)
- Foreign key relationships
- Indexes for performance
- Sample data for testing
- Triggers for automatic timestamp updates

## Project Structure

```
inventory-management/
├── inventory_management/     # Main application package
├── tests/                   # Test files
├── docker-compose.yml       # Docker services configuration
├── init-sql.sql            # Database initialization script
├── pyproject.toml          # Python project configuration
├── requirements.txt        # Python dependencies
├── Makefile               # Development commands
├── .pre-commit-config.yaml # Pre-commit hooks
└── README.md              # This file
```
