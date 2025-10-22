"""Models package for inventory management."""

from .base import Base
from .category import Category

# Import all models here so Alembic can discover them
__all__ = ["Base", "Category"]
