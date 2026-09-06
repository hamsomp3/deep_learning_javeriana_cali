# ============================================================
# Curso de Deep Learning - Javeriana Cali
# Makefile único: orquesta Python (uv) y Slidev (pnpm)
# Reglas en CONSTITUTION.md
# ============================================================

.DEFAULT_GOAL := help
.PHONY: help python-sync python-add python-lint python-format \
        slidev-install slidev-dev slidev-build slidev-export

# ----------------------------- Ayuda -----------------------------
help: ## Listar todos los targets disponibles
	@grep -E '^[a-zA-Z0-9_-]+:.*## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

# ----------------------------- Python (uv) -----------------------------
python-sync: ## Sincronizar entorno virtual con pyproject.toml
	uv sync

python-add: ## Agregar una dependencia: make python-add PKG=<paquete>
	@test -n "$(PKG)" || (echo "Uso: make python-add PKG=<paquete>" && exit 1)
	uv add $(PKG)

python-lint: ## Linting con Ruff (uvx)
	uvx ruff check . --fix

python-format: ## Formato con Ruff (uvx)
	uvx ruff format .

# ----------------------------- Slidev -----------------------------
# Requiere que Slides/ este inicializado (pnpm) — ver CONSTITUTION.md
slidev-install: ## Instalar dependencias Slidev (pnpm)
	pnpm -C Slides install

slidev-dev: ## Servidor de desarrollo Slidev (http://localhost:3030)
	pnpm -C Slides dev

slidev-build: ## Build estático del SPA
	pnpm -C Slides build

slidev-export: ## Exportar PDF (make slidev-export OUTPUT=slides.pdf)
	pnpm -C Slides export $(or $(OUTPUT),slides.pdf)
