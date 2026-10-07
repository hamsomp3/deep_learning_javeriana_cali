<div align="center">

# 🧠 Deep Learning — Pontificia Universidad Javeriana Cali

**Curso de Deep Learning para pregrado · 4 sesiones × 2 horas**

Tutor: **Jan Polanco Velasco**

[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.13](https://img.shields.io/badge/Python-3.13-blue.svg?logo=python&logoColor=ffdd54)](https://www.python.org/downloads/)
[![Gestionado con uv](https://img.shields.io/badge/uv-gestor%20de%20paquetes-de5a9b?logo=uv&logoColor=white)](https://docs.astral.sh/uv/)
[![pnpm](https://img.shields.io/badge/pnpm-frontend-orange?logo=pnpm&logoColor=white)](https://pnpm.io/)
[![Slidev](https://img.shields.io/badge/Slidev-presentaciones-blue?logo=slidev&logoColor=white)](https://sli.dev/)
[![Ruff](https://img.shields.io/badge/code%20style-Ruff-blueviolet?logo=starship&logoColor=white)](https://docs.astral.sh/ruff/)
[![Conventional Commits](https://img.shields.io/badge/Commits-Conventional-green)](https://www.conventionalcommits.org/)
[![Estructura estable](https://img.shields.io/badge/CONSTITUTION.md-verdad%20central-critical)](CONSTITUTION.md)

</div>

---

## 📖 Tabla de contenidos

1. [¿Qué es este repositorio?](#-qué-es-este-repositorio)
2. [El curso](#-el-curso)
3. [Sesiones](#-sesiones)
4. [Arquitectura](#-arquitectura)
5. [Estructura del proyecto](#-estructura-del-proyecto)
6. [Stack técnico](#-stack-técnico)
7. [Inicio rápido](#-inicio-rápido)
8. [Comandos disponibles](#-comandos-disponibles)
9. [Guía de contribución](#-guía-de-contribución)
10. [Documentación del proyecto](#-documentación-del-proyecto)
11. [Licencia](#-licencia)
12. [Autor](#-autor)

---

## 🔎 ¿Qué es este repositorio?

Repositorio central del **Curso de Deep Learning** dictado en la **Pontificia Universidad Javeriana, sede Cali** (programa de pregrado).

Contiene, de forma versionada y reproducible:

- 🎬 **Presentaciones** construidas con [Slidev](https://sli.dev/) (Markdown + Vue + Tailwind).
- 🧪 **Material práctico** por sesión (notebooks y scripts en `Sesiones/`).
- 🐍 **Código Python reutilizable** empaquetado (`src/dl_javeriana/`).
- 📜 La **`CONSTITUTION.md`**, documento de verdad central que define stack, estructura, reglas de ingeniería y decisiones técnicas del proyecto.

> 💡 Toda decisión relevante (tecnologías, estructura, flujos) se registra y actualiza en la Constitución. Este README es la puerta de entrada pública.

---

## 🎓 El curso

| | |
|---|---|
| **Audiencia** | Estudiantes de pregrado — Pontificia Universidad Javeriana Cali |
| **Modalidad** | 4 sesiones presenciales + competencia final de cierre |
| **Duración** | 2 horas por sesión (8 horas) + cierre |
| **Tutor** | Jan Polanco Velasco |
| **Enfoque** | Fundamentos y práctica de Deep Learning con Python |

---

## 🗓️ Sesiones

| # | Sesión | Fecha | Contenido | Estado |
|---|--------|-------|-----------|--------|
| 1 | Modelos Auto Regresivos | _Pendiente_ | Regresión lineal/logística, funciones de costo, gradiente descendente, NN fully connected, activaciones, hiperparámetros, datos secuenciales | ✅ Deck + Lab |
| 2 | Redes Neuronales Recurrentes (RNN, LSTM y GRU) | _Pendiente_ | Orden temporal vs. bag of words, arquitecturas RNN, desvanecimiento del gradiente, LSTM (compuertas), GRU y bidireccionales | ✅ Deck + Lab |
| 3 | Diagnóstico, Regularización y Espectrogramas | _Pendiente_ | Curvas de pérdida, overfitting/underfitting, gradientes que se desvanecen/explosionan, dropout, early stopping, gradient clipping, STFT y espectrogramas, transición a CNN (Conv2D + Pooling) | ✅ Deck + Lab |
| 4 | Redes Neuronales Convolucionales (CNNs) | _Pendiente_ | Filtros/kernels, detección de bordes, stride, padding, pooling y extracción de patrones visuales | ✅ Deck + Lab |
| 5 | 🏆 Competencia Kaggle — Pronóstico de una Serie Temporal Anónima | _Pendiente_ | Reto de cierre: pronóstico a 24 pasos con una red neuronal, métrica RMSE, *leaderboard* y certificado por superar el baseline de persistencia | ✅ Deck · 🔒 Lab privado |

> Las fechas y contenidos se publicarán aquí y en `CONSTITUTION.md` conforme se confirmen. Cada sesión consta de un deck en `Slides/pages/sesionN.md` y material práctico en `Sesiones/sesionN/`.
> 🔒 El material de la **Sesión 5** (notebook, serie y *ground truth*) es privado y **no se versiona** (contiene las respuestas ocultas); el deck público explica las reglas sin revelar la fuente de los datos.

> 📄 **¿No usas Git?** Puedes abrir o descargar el PDF de cada sesión directamente desde aquí:
> [Sesión 1](Sesion1.pdf) · [Sesión 2](Sesion2.pdf) · [Sesión 3](Sesion3.pdf) · [Sesión 4](Sesion4.pdf) · [Sesión 5](Sesion5.pdf).

---

## 🏗️ Arquitectura

El proyecto sigue un **monolito de presentación** (un solo `Slides/` con un único `package.json`/lockfile) y un **paquete Python** gestionado con `uv`, ambos orquestados por un `Makefile` único en la raíz:

```
DL-Javeriana/
├── CONSTITUTION.md ─── verdad central (reglas, stack, decisiones)
├── Makefile ─────────── orquesta: pnpm -C Slides · uv sync · ruff
├── pyproject.toml ───── dependencias Python (uv)
│
├── Slides/ ──────────── monolito Slidev
│   ├── slides.md ────── entry point maestro (menú + importa sesiones)
│   ├── pages/sesionN.md  una sesión = un archivo
│   ├── components/ ──── Vue compartidos (LstmCell, RnnArchitectures, …)
│   ├── public/img/ ──── assets + logos institucionales
│   └── global-bottom.vue  logos SIAM + Javeriana en todo deck
│
├── Sesiones/sesionN/ ── material práctico (notebooks/scripts)
└── src/dl_javeriana/ ── paquete Python reutilizable
```

**Flujo de importación:**

```
slides.md  --src:-->  pages/sesionN.md  --usa-->  components/ · public/img/
    ^                        ^
    |                        |
  menú hub              routeAlias: sesionN (vía HubNavCard, preserva presenter)
```

**Reglas de ingeniería clave** (detalle en `CONSTITUTION.md`):

1. **Un solo Slidev**: `Slides/` con un único `package.json` y `pnpm-lock.yaml` determinista. Nada de sub-projects por sesión.
2. **Una sesión = un archivo**: `Slides/pages/sesionN.md`, importado por `Slides/slides.md` vía `src:`.
3. **Compartir, no duplicar**: `components/`, `layouts/`, `styles.css` y `setup.ts` son globales.
4. **Comandos centralizados**: todo se ejecuta con `make ...` desde la raíz.
5. **Sin Mermaid por defecto**: los diagramas usan SVG/componentes Vue; Mermaid solo si se pide explícitamente.

---

## 📁 Estructura del proyecto

```
DL-Javeriana/
├── CONSTITUTION.md          # 📜 Verdad central: stack, reglas, decisiones
├── README.md                # 🚪 Este documento
├── LICENSE                  # ⚖️ MIT
├── Makefile                 # 🔧 Orquestador: targets python-* y slidev-*
├── pyproject.toml           # 📦 Proyecto uv (paquete dl-javeriana)
├── .python-version          # 🐍 3.13 (pin de uv)
├── .gitignore               # Exclusiones (.venv, __pycache__, .DS_Store)
├── Slides/                  # 🎬 Monolito Slidev (todas las presentaciones)
│   ├── slides.md            #    Entry point maestro (menú hub + src:)
│   ├── pages/               #    sesion1.md … sesion5.md
│   ├── components/          #    Componentes Vue compartidos
│   ├── layouts/             #    Layouts personalizados compartidos
│   ├── public/              #    Assets globales + img/logos/ + img/sesionN/
│   ├── global-bottom.vue    #    Logos SIAM + Javeriana en todo deck
│   ├── styles.css           #    Estilos globales
│   └── setup.ts             #    Config global (shortcuts, etc.)
├── Sesiones/                # 🧪 Material práctico por sesión
│   ├── sesion1/sesion_1_modelos_autorregresivos.ipynb
│   ├── sesion2/sesion_2_rnn_lstm_gru.ipynb
│   ├── sesion3/sesion_3_espectrogramas_cnn.ipynb
│   └── sesion4/sesion_4_redes_convolucionales.ipynb
└── src/                     # 🐍 Paquete Python reutilizable
    └── dl_javeriana/
        └── __init__.py
```

---

## 🛠️ Stack técnico

| Categoría | Tecnología | Rol |
|-----------|------------|-----|
| **Lenguaje** | Python 3.13 | Código y notebooks del curso |
| **Paquetes Python** | [uv](https://docs.astral.sh/uv/) | Entorno virtual + `pyproject.toml` |
| **Paquetes JS** | [pnpm](https://pnpm.io/) | Dependencias de Slidev |
| **Presentaciones** | [Slidev](https://sli.dev/) | Markdown + Vue + Tailwind |
| **Calidad de código** | [Ruff](https://docs.astral.sh/ruff/) | Linting y formato |
| **Hooks** | pre-commit | Verificación previa al commit *(pendiente de configurar)* |
| **Automatización** | Make | Un único punto de entrada de comandos |
| **UI / Demos** | Streamlit | *Pendiente de confirmar* |
| **Deep Learning / Datos** | TensorFlow 2 / Keras 3 · Series temporales | Laboratorios de las sesiones |

---

## 🚀 Inicio rápido

### Prerrequisitos

- [uv](https://docs.astral.sh/uv/getting-started/installation/) (Python ≥ 3.13)
- [pnpm](https://pnpm.io/installation) (Node LTS)
- [Make](https://www.gnu.org/software/make/) (incluido en macOS/Linux)

### 1. Clonar el repositorio

```bash
git clone git@github.com:hamsomp3/deep_learning_javeriana_cali.git
cd deep_learning_javeriana_cali
```

### 2. Entorno Python

```bash
make python-sync   # Crea .venv/ e instala dependencias declaradas
```

### 3. Presentaciones

```bash
make slidev-install   # pnpm install en Slides/
make slidev-dev       # abre http://localhost:3030
```

> El deck maestro es `Slides/slides.md`, que importa cada sesión desde `Slides/pages/sesionN.md`.

### 4. Verificar la configuración disponible

```bash
make help
```

---

## ⌨️ Comandos disponibles

### 🧭 General

| Target | Descripción |
|--------|-------------|
| `make help` | Lista todos los targets disponibles con su descripción |

### 🐍 Python (`uv`)

| Target | Descripción |
|--------|-------------|
| `make python-sync` | Sincroniza el entorno virtual con `pyproject.toml` |
| `make python-add PKG=<paquete>` | Agrega una dependencia Python |
| `make python-lint` | Linting con Ruff (`ruff check . --fix`) |
| `make python-format` | Formatea el código con Ruff |

### 🎬 Slidev (`pnpm`) — general

| Target | Descripción |
|--------|-------------|
| `make slidev-install` | Instala las dependencias de Slidev (`pnpm -C Slides install`) |
| `make slidev-dev` | Servidor de desarrollo del deck completo (`http://localhost:3030`) |
| `make slidev-build` | Build estático del SPA |
| `make slidev-export [OUTPUT=<archivo.pdf>]` | Exporta el deck completo a PDF (con `OUTPUT` la salida va a la raíz del repo) |
| `make slidev-format` | Formatea `slides.md` con Slidev |

### 🎞️ Slidev — dev por sesión (aislado)

Cada target crea un entry point temporal, levanta Slidev con **solo esa sesión** y limpia al salir.

| Target | Descripción |
|--------|-------------|
| `make slidev-s1` | Sesión 1 — Modelos Auto Regresivos |
| `make slidev-s2` | Sesión 2 — RNN, LSTM y GRU |
| `make slidev-s3` | Sesión 3 — Diagnóstico, Regularización y Espectrogramas |
| `make slidev-s4` | Sesión 4 — Redes Neuronales Convolucionales (CNNs) |
| `make slidev-s5` | Sesión 5 — Competencia Kaggle (serie temporal anónima) |

### 📄 Slidev — exportar una sesión a PDF (individual)

| Target | Descripción |
|--------|-------------|
| `make slidev-s1-export` | Exporta la Sesión 1 a `Sesion1.pdf` |
| `make slidev-s2-export` | Exporta la Sesión 2 a `Sesion2.pdf` |
| `make slidev-s3-export` | Exporta la Sesión 3 a `Sesion3.pdf` |
| `make slidev-s4-export` | Exporta la Sesión 4 a `Sesion4.pdf` |
| `make slidev-s5-export` | Exporta la Sesión 5 a `Sesion5.pdf` |
| `make slidev-all-export` | Exporta las 5 sesiones en secuencia |

### 🧹 Limpieza

| Target | Descripción |
|--------|-------------|
| `make clean` | Elimina entry points temporales (`sesion*-dev.md`, `sesion*-export.md`) y cachés de Python |

---

## 🤝 Guía de contribución

### Flujo diario

```bash
git pull --rebase                       # 0. Sincronizar al iniciar
# ...trabajo...
git status                              # 1. Revisar cambios
make slidev-dev                         # 2. Verificar diapositivas
make python-lint && make python-format  # 3. Calidad de código
find Sesiones -name "*.ipynb" -exec uv run jupyter nbconvert --clear-output --inplace {} +  # 3.5. Limpiar outputs de notebooks
git add -A
git commit -m "tipo: mensaje descriptivo"
git push
```

### Notebooks (sin outputs)

Todo notebook se commitea *clean*: **sin outputs ni `execution_count`**. Si ejecutaste alguno en `Sesiones/`, límpialo antes del commit:

```bash
uv run jupyter nbconvert --clear-output --inplace Sesiones/sesionN/*.ipynb
```

> Detalle y justificación en [`CONSTITUTION.md`](CONSTITUTION.md).

### Convención de commits

Este proyecto usa [Conventional Commits](https://www.conventionalcommits.org/):

| Tipo | Uso |
|------|-----|
| `feat:` | Nueva funcionalidad (sesión, componente, demo) |
| `fix:` | Corrección de errores |
| `docs:` | Cambios de documentación (incluida `CONSTITUTION.md`) |
| `refactor:` | Refactorización sin cambio de lógica |
| `style:` | Lint, formato, espacios |
| `chore:` | Mantenimiento y configuración |

### Regla de oro

> Cualquier cambio significativo (nuevas sesiones, tecnologías, arquitecturas o reglas) **debe** reflejarse en `CONSTITUTION.md` dentro del mismo commit.

---

## 📜 Documentación del proyecto

La fuente de verdad de este repositorio es [`CONSTITUTION.md`](CONSTITUTION.md):

- Contexto y alcance del curso
- Directiva de mantenimiento
- Stack técnico y decisiones registradas
- Estructura canónica y reglas de ingeniería de las presentaciones
- Flujo diario y convenciones

Si este README y la Constitución discrepan, **gana la Constitución**.

---

## ⚖️ Licencia

Distribuido bajo la licencia [MIT](LICENSE). Puedes usar, modificar y redistribuir el material citando la autoría.

---

## 👤 Autor

**Jan Polanco Velasco**

- GitHub: [@hamsomp3](https://github.com/hamsomp3)

<p align="center">
  Hecho con 🐍 + ☕ para los estudiantes de la Javeriana Cali.
</p>
