# ============================================================
# Curso de Deep Learning - Javeriana Cali
# Makefile único: orquesta Python (uv) y Slidev (pnpm)
# Reglas en CONSTITUTION.md
# ============================================================

.DEFAULT_GOAL := help
.PHONY: help python-sync python-add python-lint python-format \
        slidev-install slidev-dev slidev-build slidev-export slidev-format \
        slidev-c1 slidev-c2 slidev-c3 slidev-c4 \
        slidev-c1-export slidev-c2-export slidev-c3-export slidev-c4-export \
        slidev-all-export clean

# ----------------------------- Ayuda -----------------------------
help: ## Listar todos los targets disponibles
	@echo ""
	@echo "  DL-Javeriana — Makefile"
	@echo "  ========================"
	@echo ""
	@echo "  PYTHON (uv)"
	@echo "  ------------"
	@echo "  make python-sync      -> Sincronizar entorno virtual con pyproject.toml"
	@echo "  make python-add PKG=  -> Agregar una dependencia Python"
	@echo "  make python-lint      -> Linting con Ruff"
	@echo "  make python-format    -> Formato con Ruff"
	@echo ""
	@echo "  SLIDEV (pnpm) — Presentaciones"
	@echo "  -------------------------------"
	@echo "  make slidev-install   -> Instalar dependencias Slidev"
	@echo "  make slidev-dev       -> Servidor de desarrollo (http://localhost:3030)"
	@echo "  make slidev-build     -> Build estático del SPA"
	@echo "  make slidev-export    -> Exportar monolito completo a PDF"
	@echo "  make slidev-format    -> Formatear slides.md con Slidev"
	@echo ""
	@echo "  SLIDEV — Dev por sesión (aislada)"
	@echo "  ----------------------------------"
	@echo "  make slidev-c1        -> Clase 1: Modelos Auto Regresivos"
	@echo "  make slidev-c2        -> Clase 2: RNN, LSTM y GRU"
	@echo "  make slidev-c3        -> Clase 3"
	@echo "  make slidev-c4        -> Clase 4"
	@echo ""
	@echo "  SLIDEV — Exportar sesión a PDF (individual)"
	@echo "  --------------------------------------------"
	@echo "  make slidev-c1-export -> PDF solo Clase 1: Modelos Auto Regresivos"
	@echo "  make slidev-c2-export -> PDF solo Clase 2: RNN, LSTM y GRU"
	@echo "  make slidev-c3-export -> PDF solo Clase 3"
	@echo "  make slidev-c4-export -> PDF solo Clase 4"
	@echo "  make slidev-all-export -> Exportar las 4 sesiones en secuencia"
	@echo ""
	@echo "  LIMPIEZA"
	@echo "  --------"
	@echo "  make clean            -> Limpiar entry points temporales y cache"
	@echo ""

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

# ----------------------------- Slidev (General) -----------------------------
slidev-install: ## Instalar dependencias Slidev (pnpm)
	pnpm -C Slides install

slidev-dev: ## Servidor de desarrollo Slidev (http://localhost:3030)
	pnpm -C Slides dev

slidev-build: ## Build estático del SPA
	pnpm -C Slides build

slidev-export: ## Exportar monolito completo a PDF
	pnpm -C Slides export -- --with-clicks

slidev-format: ## Formatear slides.md con Slidev
	pnpm -C Slides exec slidev format

# ----------------------------- Slidev — Dev por sesión -----------------------------
# Crea un entry point temporal que importa solo una sesión y levanta el dev server.

slidev-c1: ## Clase 1: Modelos Auto Regresivos (dev aislado)
	@echo "---" > Slides/sesion1-dev.md
	@echo "src: ./pages/sesion1.md" >> Slides/sesion1-dev.md
	@echo "---" >> Slides/sesion1-dev.md
	@echo ">>> Iniciando Slidev para Clase 1 (aislada)..."
	@cd Slides && pnpm exec slidev sesion1-dev.md --open
	@rm -f Slides/sesion1-dev.md

slidev-c2: ## Clase 2: RNN, LSTM y GRU (dev aislado)
	@echo "---" > Slides/sesion2-dev.md
	@echo "src: ./pages/sesion2.md" >> Slides/sesion2-dev.md
	@echo "---" >> Slides/sesion2-dev.md
	@echo ">>> Iniciando Slidev para Clase 2 (aislada)..."
	@cd Slides && pnpm exec slidev sesion2-dev.md --open
	@rm -f Slides/sesion2-dev.md

slidev-c3: ## Clase 3 (dev aislado)
	@echo "---" > Slides/sesion3-dev.md
	@echo "src: ./pages/sesion3.md" >> Slides/sesion3-dev.md
	@echo "---" >> Slides/sesion3-dev.md
	@echo ">>> Iniciando Slidev para Clase 3 (aislada)..."
	@cd Slides && pnpm exec slidev sesion3-dev.md --open
	@rm -f Slides/sesion3-dev.md

slidev-c4: ## Clase 4 (dev aislado)
	@echo "---" > Slides/sesion4-dev.md
	@echo "src: ./pages/sesion4.md" >> Slides/sesion4-dev.md
	@echo "---" >> Slides/sesion4-dev.md
	@echo ">>> Iniciando Slidev para Clase 4 (aislada)..."
	@cd Slides && pnpm exec slidev sesion4-dev.md --open
	@rm -f Slides/sesion4-dev.md

# ----------------------------- Slidev — Export por sesión (individual) -----------------------------
# Crea un entry point temporal, exporta solo esa sesión a PDF, y limpia.

slidev-c1-export: ## Exportar Clase 1 a PDF (individual)
	@echo ">>> Exportando Clase 1 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion1.md\n---\n' > Slides/sesion1-export.md
	@cd Slides && pnpm exec slidev export sesion1-export.md --output "../Sesion1.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion1-export.md
	@echo ">>> PDF generado: Sesion1.pdf"

slidev-c2-export: ## Exportar Clase 2: RNN, LSTM y GRU a PDF (individual)
	@echo ">>> Exportando Clase 2 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion2.md\n---\n' > Slides/sesion2-export.md
	@cd Slides && pnpm exec slidev export sesion2-export.md --output "../Sesion2.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion2-export.md
	@echo ">>> PDF generado: Sesion2.pdf"

slidev-c3-export: ## Exportar Clase 3 a PDF (individual)
	@echo ">>> Exportando Clase 3 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion3.md\n---\n' > Slides/sesion3-export.md
	@cd Slides && pnpm exec slidev export sesion3-export.md --output "../Sesion3.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion3-export.md
	@echo ">>> PDF generado: Sesion3.pdf"

slidev-c4-export: ## Exportar Clase 4 a PDF (individual)
	@echo ">>> Exportando Clase 4 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion4.md\n---\n' > Slides/sesion4-export.md
	@cd Slides && pnpm exec slidev export sesion4-export.md --output "../Sesion4.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion4-export.md
	@echo ">>> PDF generado: Sesion4.pdf"

slidev-all-export: slidev-c1-export slidev-c2-export slidev-c3-export slidev-c4-export ## Exportar las 4 sesiones a PDF
	@echo ">>> Todas las sesiones exportadas a PDF"

# ----------------------------- Limpieza -----------------------------
clean: ## Limpiar entry points temporales y cache
	@echo ">>> Limpiando artefactos temporales de exportación..."
	@rm -f Slides/sesion*-export.md Slides/sesion*-dev.md
	@find . -type d -name "__pycache__" -prune -exec rm -rf {} + 2>/dev/null || true
	@find . -name "*.pyc" -delete 2>/dev/null || true
	@echo ">>> Limpieza completada"
