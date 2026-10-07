# ============================================================
# Curso de Deep Learning - Javeriana Cali
# Makefile único: orquesta Python (uv) y Slidev (pnpm)
# Reglas en CONSTITUTION.md
# ============================================================

.DEFAULT_GOAL := help
.PHONY: help python-sync python-add python-lint python-format \
        slidev-install slidev-dev slidev-build slidev-export slidev-format \
        slidev-s1 slidev-s2 slidev-s3 slidev-s4 \
        slidev-s1-export slidev-s2-export slidev-s3-export slidev-s4-export \
        slidev-all-export clean

# ----------------------------- Títulos de las sesiones -----------------------------
# Fuente única de verdad de los títulos de sesión usados por `make help`.
S1_TITLE := Modelos Auto Regresivos
S2_TITLE := RNN, LSTM y GRU
S3_TITLE := Diagnóstico, Regularización y Espectrogramas
S4_TITLE := Redes Neuronales Convolucionales (CNNs)

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
	@echo "  make slidev-export    -> Exportar monolito completo a PDF (opcional OUTPUT=)"
	@echo "  make slidev-format    -> Formatear slides.md con Slidev"
	@echo ""
	@echo "  SLIDEV — Dev por sesión (aislada)"
	@echo "  ----------------------------------"
	@echo "  make slidev-s1        -> Sesión 1: $(S1_TITLE)"
	@echo "  make slidev-s2        -> Sesión 2: $(S2_TITLE)"
	@echo "  make slidev-s3        -> Sesión 3: $(S3_TITLE)"
	@echo "  make slidev-s4        -> Sesión 4: $(S4_TITLE)"
	@echo ""
	@echo "  SLIDEV — Exportar sesión a PDF (individual)"
	@echo "  --------------------------------------------"
	@echo "  make slidev-s1-export -> PDF solo Sesión 1: $(S1_TITLE)"
	@echo "  make slidev-s2-export -> PDF solo Sesión 2: $(S2_TITLE)"
	@echo "  make slidev-s3-export -> PDF solo Sesión 3: $(S3_TITLE)"
	@echo "  make slidev-s4-export -> PDF solo Sesión 4: $(S4_TITLE)"
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

slidev-export: ## Exportar monolito completo a PDF (opcional: OUTPUT=<archivo.pdf>)
	@echo ">>> Exportando monolito completo a PDF..."
	pnpm -C Slides export -- --with-clicks $(if $(OUTPUT),--output "../$(OUTPUT)")
	@test -z "$(OUTPUT)" || echo ">>> PDF generado: $(OUTPUT)"

slidev-format: ## Formatear slides.md con Slidev
	pnpm -C Slides exec slidev format

# ----------------------------- Slidev — Dev por sesión -----------------------------
# Crea un entry point temporal que importa solo una sesión y levanta el dev server.

slidev-s1: ## Sesión 1: Modelos Auto Regresivos (dev aislado)
	@echo "---" > Slides/sesion1-dev.md
	@echo "src: ./pages/sesion1.md" >> Slides/sesion1-dev.md
	@echo "---" >> Slides/sesion1-dev.md
	@echo ">>> Iniciando Slidev para Sesión 1 (aislada)..."
	@cd Slides && pnpm exec slidev sesion1-dev.md --open
	@rm -f Slides/sesion1-dev.md

slidev-s2: ## Sesión 2: RNN, LSTM y GRU (dev aislado)
	@echo "---" > Slides/sesion2-dev.md
	@echo "src: ./pages/sesion2.md" >> Slides/sesion2-dev.md
	@echo "---" >> Slides/sesion2-dev.md
	@echo ">>> Iniciando Slidev para Sesión 2 (aislada)..."
	@cd Slides && pnpm exec slidev sesion2-dev.md --open
	@rm -f Slides/sesion2-dev.md

slidev-s3: ## Sesión 3: Diagnóstico, Regularización y Espectrogramas (dev aislado)
	@echo "---" > Slides/sesion3-dev.md
	@echo "src: ./pages/sesion3.md" >> Slides/sesion3-dev.md
	@echo "---" >> Slides/sesion3-dev.md
	@echo ">>> Iniciando Slidev para Sesión 3 (aislada)..."
	@cd Slides && pnpm exec slidev sesion3-dev.md --open
	@rm -f Slides/sesion3-dev.md

slidev-s4: ## Sesión 4: Redes Neuronales Convolucionales (CNNs) (dev aislado)
	@echo "---" > Slides/sesion4-dev.md
	@echo "src: ./pages/sesion4.md" >> Slides/sesion4-dev.md
	@echo "---" >> Slides/sesion4-dev.md
	@echo ">>> Iniciando Slidev para Sesión 4 (aislada)..."
	@cd Slides && pnpm exec slidev sesion4-dev.md --open
	@rm -f Slides/sesion4-dev.md

# ----------------------------- Slidev — Export por sesión (individual) -----------------------------
# Crea un entry point temporal, exporta solo esa sesión a PDF, y limpia.

slidev-s1-export: ## Exportar Sesión 1: Modelos Auto Regresivos a PDF (individual)
	@echo ">>> Exportando Sesión 1 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion1.md\n---\n' > Slides/sesion1-export.md
	@cd Slides && pnpm exec slidev export sesion1-export.md --output "../Sesion1.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion1-export.md
	@echo ">>> PDF generado: Sesion1.pdf"

slidev-s2-export: ## Exportar Sesión 2: RNN, LSTM y GRU a PDF (individual)
	@echo ">>> Exportando Sesión 2 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion2.md\n---\n' > Slides/sesion2-export.md
	@cd Slides && pnpm exec slidev export sesion2-export.md --output "../Sesion2.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion2-export.md
	@echo ">>> PDF generado: Sesion2.pdf"

slidev-s3-export: ## Exportar Sesión 3: Diagnóstico, Regularización y Espectrogramas a PDF (individual)
	@echo ">>> Exportando Sesión 3 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion3.md\n---\n' > Slides/sesion3-export.md
	@cd Slides && pnpm exec slidev export sesion3-export.md --output "../Sesion3.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion3-export.md
	@echo ">>> PDF generado: Sesion3.pdf"

slidev-s4-export: ## Exportar Sesión 4: Redes Neuronales Convolucionales (CNNs) a PDF (individual)
	@echo ">>> Exportando Sesión 4 a PDF..."
	@printf -- '---\nsrc: ./pages/sesion4.md\n---\n' > Slides/sesion4-export.md
	@cd Slides && pnpm exec slidev export sesion4-export.md --output "../Sesion4.pdf" --with-clicks --timeout 120000
	@rm -f Slides/sesion4-export.md
	@echo ">>> PDF generado: Sesion4.pdf"

slidev-all-export: slidev-s1-export slidev-s2-export slidev-s3-export slidev-s4-export ## Exportar las 4 sesiones a PDF
	@echo ">>> Todas las sesiones exportadas a PDF"

# ----------------------------- Limpieza -----------------------------
clean: ## Limpiar entry points temporales y cache
	@echo ">>> Limpiando artefactos temporales de exportación..."
	@rm -f Slides/sesion*-export.md Slides/sesion*-dev.md
	@find . -type d -name "__pycache__" -prune -exec rm -rf {} + 2>/dev/null || true
	@find . -name "*.pyc" -delete 2>/dev/null || true
	@echo ">>> Limpieza completada"
