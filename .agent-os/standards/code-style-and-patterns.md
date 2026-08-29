# Code Style & Architecture Standards

## General Principles
- Write modular, clean, and self-documenting code.
- Always include type annotations and clear docstrings where applicable.
- Avoid large monolithic files: separate concerns across cohesive modules.

## Error Handling & Logging
- Use specific exceptions rather than catching general `Exception` where possible.
- Provide descriptive error messages with actionable context.

## State Management & Configuration
- Store sensitive values in environment variables (`.env`).
- Never commit secrets, tokens, or credentials to version control.
