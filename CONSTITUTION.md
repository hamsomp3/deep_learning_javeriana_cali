# Curso de Deep Learning - Pontificia Universidad Javeriana Cali (Pregrado)

> **Contexto del proyecto:** Repositorio central para las sesiones del **Curso de Deep Learning**
> dirigido a estudiantes de **pregrado** de la Pontificia Universidad Javeriana, sede Cali.
> **Formato:** 4 sesiones de 2 horas cada una. Tutor: **Jan Polanco Velasco**.
> Trackeado al repositorio remoto `hamsomp3/deep_learning_javeriana_cali`.

---

## 📌 Directiva de Mantenimiento de la Constitución

> ⚠️ **REGLA FUNDAMENTAL:** Cada vez que se realicen cambios significativos en el proyecto (nuevas funcionalidades, cambios arquitectónicos, adición de nuevas clases/módulos o ajustes en las tecnologías utilizadas), **se debe actualizar este archivo `CONSTITUTION.md`** para mantener la verdad central del proyecto adecuadamente documentada.

---

## 🎯 Alcance del Curso

| Elemento | Detalle |
|----------|---------|
| **Audiencia** | Estudiantes de pregrado, Pontificia Universidad Javeriana Cali |
| **Duración total** | 8 horas (4 sesiones × 2 horas) |
| **Sesión 1** | Fecha: PENDIENTE — Contenido: PENDIENTE |
| **Sesión 2** | Fecha: PENDIENTE — Contenido: PENDIENTE |
| **Sesión 3** | Fecha: PENDIENTE — Contenido: PENDIENTE |
| **Sesión 4** | Fecha: PENDIENTE — Contenido: PENDIENTE |

> Las fechas y el contenido de cada sesión se completarán cuando sean provistos.
> Cada sesión tendrá: diapositivas en `Slides/pages/sesionN.md` + material práctico en `Sesiones/sesionN/`.

---

## 📝 Notas y Tareas Pendientes

- [ ] Definir fechas de las 4 sesiones.
- [ ] Definir contenido temático de cada sesión.
- [ ] Confirmar si el proyecto usará **Streamlit** para demos interactivas (hoy: PENDIENTE).
- [ ] Definir fuentes de **Datos** del curso (datasets por sesión).
- [ ] Inicializar `Slides/` como proyecto Slidev (`pnpm init` + deps + lockfile).
- [ ] Configurar **Ruff** y **pre-commit** en el repo.
- [ ] .

---

## 🔄 Flujo Diario (Commit + Push)

```bash
# 0. Check de sincronización al iniciar sesión:
git pull --rebase

# 1. Ver cambios
git status

# 2. Verificar presentación Slidev
make slidev-dev
# (verificar en http://localhost:3030, cerrar con Ctrl+C)

# 3. Linting y formato
make python-lint && make python-format

# 4. Agregar y commitear
git add -A
git commit -m "tipo: mensaje descriptivo"

# 5. Subir a GitHub
git push
```

> Nota: cuando se confirme Streamlit, se agregará `make python-run` a este flujo.

### Convención de Commits
Usar la especificación de [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` — Nueva funcionalidad
- `fix:` — Corrección de bug
- `docs:` — Cambios en la documentación
- `refactor:` — Refactorización de código
- `style:` — Formato, linting, espacios (sin cambio de lógica)
- `chore:` — Tareas de mantenimiento o configuración

---

## 🛠️ Stack Técnico del Proyecto

| Categoría | Tecnologías |
|-----------|-------------|
| **Lenguaje** | Python 3.13 |
| **Gestor de Paquetes (Python)** | [uv](https://docs.astral.sh/uv/) |
| **Gestor de Paquetes (Frontend/Slidev)** | [pnpm](https://pnpm.io/) |
| **Deep Learning** | PENDIENTE (a definir con el contenido de las sesiones) |
| **Datos** | PENDIENTE |
| **UI / Demos** | Streamlit — *PENDIENTE de confirmar* |
| **Presentaciones** | [Slidev](https://sli.dev/) (Markdown + Vue + Tailwind) |
| **Linting** | Ruff |
| **Pre-commit** | pre-commit |

---

## 📜 Historial de Decisiones Técnicas

### Repositorio
- **Nombre:** `deep_learning_javeriana_cali`
- **Cuenta GitHub:** `hamsomp3`
- **URL SSH:** `git@github.com:hamsomp3/deep_learning_javeriana_cali.git`
- **URL HTTPS:** `https://github.com/hamsomp3/deep_learning_javeriana_cali`
- **Rama principal:** `main`

### Proyecto Python
- **Paquete:** `dl-javeriana` (definido en `pyproject.toml`, build backend `uv_build`).
- **Python:** 3.13 (fijado en `.python-version`).
- Código fuente en `src/dl_javeriana/`.

### Migración a `uv`
- `uv` como gestor de paquetes de alto rendimiento.
- Las dependencias se declaran en `pyproject.toml`.
- Entorno virtual ubicado en `.venv/` (no trackeado).

### Estructura de carpetas
- **Convención en mayúsculas** para los dos módulos principales del curso:
  - `Slides/` → monolito Slidev (todas las presentaciones).
  - `Sesiones/` → material práctico por sesión (notebooks/scripts).
- Un **único `Makefile` en la raíz** orquesta comandos Python y Slidev.

---

## 📁 Estructura Canónica del Repositorio

```
DL-Javeriana/
├── CONSTITUTION.md          # Verdad central del proyecto (este archivo)
├── Makefile                 # Comandos: python-*, slidev-*
├── pyproject.toml           # Proyecto uv (dependencias Python)
├── .python-version          # 3.13
├── src/
│   └── dl_javeriana/        # Código Python reutilizable
├── Slides/                  # Monolito Slidev (ver sección siguiente)
└── Sesiones/                # Material práctico por sesión
    ├── sesion1/
    ├── sesion2/
    ├── sesion3/
    └── sesion4/
```

---

## 🎬 Presentaciones con Slidev (Reglas de Ingeniería)

> Todas las diapositivas y presentaciones del curso se construyen con **[Slidev](https://sli.dev/)** (Markdown + Vue + Tailwind) para diapositivas interactivas, versionables y reproducibles.

### Estructura Canónica de Presentaciones (Monolito Slidev)

```
Slides/
├── slides.md              # Entry point maestro (importa todas las sesiones)
├── package.json           # Dependencias Slidev (pnpm) — 1 solo lockfile
├── pnpm-lock.yaml         # Lock determinista compartido
├── components/            # Componentes Vue COMPARTIDOS
├── layouts/               # Layouts personalizados compartidos
├── public/                # Assets globales (logos, favicons, img/sesionN/ por deck)
├── styles.css             # Estilos globales
├── setup.ts               # Config global (shortcuts, etc.)
└── pages/                 # Slides por sesión (importables vía src:)
    ├── sesion1.md         # Diapositivas Sesión 1
    ├── sesion2.md         # Diapositivas Sesión 2
    ├── sesion3.md         # Diapositivas Sesión 3
    └── sesion4.md         # Diapositivas Sesión 4
```

> **Regla:** Un **único** proyecto Slidev (`Slides/`) con **un solo** `package.json` y `pnpm-lock.yaml`. Cada sesión vive en `Slides/pages/sesionN.md` y se importa en `Slides/slides.md` vía `src: ./pages/sesionN.md`. Componentes, layouts, estilos y assets son compartidos. Los comandos Slidev se ejecutan desde el `Makefile` de la raíz (`make slidev-dev`, etc.).

> **Deploy:** PENDIENTE (evaluar Netlify/Vercel/GitHub Pages cuando los decks estén listos).

### Frontmatter Obligatorio (Institucional)

Todo `slides.md` debe iniciar con:

```yaml
---
theme: seriph
background: https://cover.sli.dev
title: Sesion N - Título Descriptivo
info: |
  ## Sesión N: Título Descriptivo
  DEEP LEARNING
  Pontificia Universidad Javeriana Cali — Pregrado
  Tutor: Jan Polanco Velasco
class: text-center
drawings:
  persist: false
transition: slide-left
mdc: true
---
```

---

## ⚙️ Configuración Local (No trackear)

> Configuración específica de la máquina local.
> **NO incluir en commits.**
> Copiar a nuevos proyectos personales cuando sea necesario.

### Identidad Git Automática

`~/.gitconfig` (global):
```ini
[includeIf "gitdir:~/Desktop/Repositorios/personal/"]
    path = ~/.gitconfig-personal
```

`~/.gitconfig-personal`:
```ini
[user]
    email = hamsomp3@gmail.com
    name = Jan Polanco V.

[core]
    sshCommand = ssh -i ~/.ssh/id_ed25519
```

**Efecto:** Todo proyecto dentro de `~/Desktop/Repositorios/personal/` usa automáticamente:
- **Email:** `hamsomp3@gmail.com`
- **Nombre:** Jan Polanco V.
- **Llave SSH:** `~/.ssh/id_ed25519`

Sin necesidad de `gh`, variables de entorno ni flags manuales.

### Remote Actual

```text
origin  git@github.com:hamsomp3/deep_learning_javeriana_cali.git (fetch)
origin  git@github.com:hamsomp3/deep_learning_javeriana_cali.git (push)
```
