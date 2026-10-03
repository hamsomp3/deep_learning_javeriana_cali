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
| **Sesión 1** | Fecha: PENDIENTE — **Modelos Auto Regresivos** (regresión, funciones de costo, gradiente descendente, NN fully connected, activaciones, hiperparámetros, datos secuenciales) |
| **Sesión 2** | Fecha: PENDIENTE — **Redes Neuronales Recurrentes (RNN, LSTM y GRU)**: orden temporal vs. bag of words, arquitecturas RNN (Many-to-One, One-to-Many, Many-to-Many), desvanecimiento del gradiente, LSTM (celda de memoria y compuertas), GRU y redes bidireccionales |
| **Sesión 3** | Fecha: PENDIENTE — **Diagnóstico, Regularización y Espectrogramas**: curvas de pérdida (overfitting/underfitting), patologías del gradiente (desvanecimiento/explosión), dropout, early stopping, gradient clipping, procesamiento de audio (STFT) y espectrogramas como puente hacia las CNN (Conv2D + Pooling) |
| **Sesión 4** | Fecha: PENDIENTE — **Redes Neuronales Convolucionales (CNNs)**: imagen como tensor, colapso de la MLP (flatten), convolución 2D y kernels, padding/stride, convolución 3D multicanal, pooling, jerarquía visual y arquitectura canónica en Keras |

> Las fechas y el contenido de cada sesión se completarán cuando sean provistos.
> Cada sesión tendrá: diapositivas en `Slides/pages/sesionN.md` + material práctico en `Sesiones/sesionN/`.

---

## 📝 Notas y Tareas Pendientes

- [ ] Definir fechas de las 4 sesiones.
- [x] Definir contenido temático de la sesión 2 (RNN, LSTM y GRU — deck creado).
- [x] Definir contenido temático de la sesión 3 (diagnóstico, regularización y espectrogramas — deck creado).
- [x] Definir contenido temático de la sesión 4 (CNNs — deck creado).
- [ ] Confirmar si el proyecto usará **Streamlit** para demos interactivas (hoy: PENDIENTE).
- [ ] Definir fuentes de **Datos** del curso (datasets por sesión).
- [x] Inicializar `Slides/` como proyecto Slidev (hecho: scaffold `slidev@52.19.1`, migrado a pnpm).
- [ ] Configurar **Ruff** y **pre-commit** en el repo.
- [x] Completar `sesion3.md` (deck creado con 3 componentes interactivos: `TrainingCurvesDiagnostics`, `PoolingSimulator`, `SpectrogramHeatmap`).
- [x] Crear el Laboratorio 3 (`Sesiones/sesion3/sesion_3_espectrogramas_cnn.ipynb` — espectrogramas + CNN).
- [x] Completar `sesion4.md` (deck creado con componente interactivo: `ConvolutionSimulator`).
- [ ] Crear el Laboratorio 4 (`Sesiones/sesion4/` — hoy solo `.gitkeep`; notebook pendiente: convoluciones manuales, CNN en Keras, feature maps).
- [x] Fix presenter del menú hub (`HubNavCard` — ver *Historial de Decisiones*).
- [x] QA layout DOM v2 (Playwright, 85 slides en estado final de clicks): 4 overflows reales corregidos (`/41` Talón de Aquiles 90px, `/57` Audio 37px, `/58` Espectrograma 4px, `/61` Pooling S3 67px); `/69` es apilado intencional de canales RGB (falso positivo). Scripts en `qa/` temporal, no versionados.
- [x] Regla de navegación del menú: toda sesión nueva en `pages/` requiere `routeAlias: sesionN` (ver *Presentaciones con Slidev*).
- [x] Regla HTML/SVG sin líneas en blanco internas (evita errores *Invalid end tag* al compilar).

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
| **Deep Learning** | TensorFlow 2 / Keras 3 |
| **Datos** | Series temporales (*Monthly Sunspots*, `jbrownlee/Datasets`) + tareas sintéticas |
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

### Licencia
- **MIT** adoptada para todo el repositorio (código y material del curso).
- **Titular:** Jan Polanco Velasco (2026).
- **Archivo:** `LICENSE` en la raíz; badge de licencia en `README.md`.
- **Rol del README:** puerta de entrada pública del repo (badges, arquitectura, quickstart). Ante discrepancia README vs Constitución, **gana la Constitución**.

### Scaffold Slidev
- Creado con `pnpm create slidev` (Slidev **v52.19.1**, tema `seriph`).
- **Migrado de npm → pnpm**: se borraron `package-lock.json` y `node_modules` del scaffold; ahora `Slides/pnpm-lock.yaml` es el lock determinista (regla: un solo gestor = pnpm).
- El proyecto se **aplanó a la raíz `Slides/`** (originalmente el scaffold lo creó en `Slides/deep-learnig/`). No debe haber anidamiento extra.
- `pnpm-workspace.yaml` incluye `shamefullyHoist: true` y `allowBuilds.playwright-chromium: true` (necesario para `slidev export`).
- Nombre del paquete: `dl-javeriana-slides` (corrige el typo `deep-learnig` del scaffold).

### Deck Sesión 3 — Diagnóstico, Regularización y Espectrogramas
- **Estructura pedagógica en 4 actos:** (1) diagnóstico clínico del entrenamiento, (2) arsenal de estabilización y regularización, (3) de señales 1D a imágenes 2D (STFT/espectrogramas), (4) introducción a la convolución y pooling.
- **Tres componentes Vue interactivos nuevos** en `Slides/components/`:
  - `TrainingCurvesDiagnostics.vue` — alterna 5 estados clínicos (overfitting, underfitting, good fit, gradientes que explotan y que se desvanecen) con receta de regularización y perfil de `‖∇W‖` por capa.
  - `PoolingSimulator.vue` — matriz 4×4 → salida 2×2 o 1×1 con modos **Max / Average / Global Average Pooling**, calculados dinámicamente.
  - `SpectrogramHeatmap.vue` — espectrograma sintético `Tiempo × Frecuencia` con conmutador de escala **lineal / dB** y tensor `(124, 129, 1)`.
- **Puente audio → CNN:** el lab de la sesión clasifica 3 clases de audio usando `tf.signal.stft` + arquitectura `Conv2D → MaxPooling2D → GlobalAveragePooling2D → Dropout → Dense(softmax)`.

### Deck Sesión 4 — Redes Neuronales Convolucionales (CNNs)
- **Estructura pedagógica en 4 actos:** (1) de la imagen al tensor y colapso de la MLP, (2) operación de convolución 2D, (3) geometría (padding/stride/volúmenes 3D), (4) pooling, jerarquía y arquitectura canónica.
- **Componente Vue interactivo nuevo** en `Slides/components/`:
  - `ConvolutionSimulator.vue` — kernel $3 \times 3$ deslizante sobre matriz $5 \times 5$ (Sobel Vertical / Laplaciano / Identidad), salida $3 \times 3$ clicable con cálculo $\Sigma (X_{local} \odot K)$ en vivo.
- **Ecuación dimensional universal:** $O = \lfloor (N + 2p - f)/s \rfloor + 1$ con ejemplo MNIST $28 \to 14$ ($f=3$, $p=1$, $s=2$) y Magic Move Keras `Conv2D + MaxPooling2D → Flatten → Dropout → Dense(softmax)`.

### Fix Presenter del Menú Hub — `HubNavCard`
- **Síntoma:** con `make slidev-dev` (pestañas `:3030` + `:3030/presenter/`), clicar una sesión desde el índice (`/2`) mataba el modo presenter.
- **Causa raíz:** el hub usaba `<Link to="/sesionN">` crudo (`RouterLink`). Slidev genera rutas como `getSlideRoutePath`: normal `/<alias>` vs. presenter `/presenter/<alias>`; el link crudo navega a `/sesionN` y **abandona `/presenter/*`**. Verificado en `node_modules/@slidev/client/logic/slidePath.ts` y `composables/useNav.ts` (`go()` sí preserva el prefijo).
- **Solución:** `Slides/components/HubNavCard.vue` — wrapper que replica el patrón del `TocList` oficial (`builtin/TocList.vue:56`): `<Link :to="isPresenter ? \`/presenter${to}\` : to">`. El hub (`Slides/slides.md`) usa `<HubNavCard to="/sesionN">` en las 4 cards.
- **Regla de imports Slidev:** en componentes propios importar desde el entrypoint público (`import { useNav } from '@slidev/client'`); el subpath profundo (`@slidev/client/composables/useNav`) **rompe el build** (`[UNLOADABLE_DEPENDENCY]`, exit 1).
- **Verificación:** `pnpm -C Slides build` en verde + `200` en `/2`, `/sesion1`, `/presenter/2`, `/presenter/sesion1`. Prueba manual: abrir `/presenter/2`, clicar sesión → debe ir a `/presenter/sesionN` con notas/preview intactos.

### Estructura de carpetas
- **Convención en mayúsculas** para los dos módulos principales del curso:
  - `Slides/` → monolito Slidev (todas las presentaciones).
  - `Sesiones/` → material práctico por sesión (notebooks/scripts).
- Un **único `Makefile` en la raíz** orquesta comandos Python y Slidev.

### Material Práctico (`Sesiones/`)

- **Sesión 1:** `Sesiones/sesion1/sesion_1_modelos_autorregresivos.ipynb` — red **MLP autorregresiva** sobre *Monthly Sunspots* (FFT, descomposición estacional, ventana deslizante 2D, inferencia recursiva).
- **Sesión 2:** `Sesiones/sesion2/sesion_2_rnn_lstm_gru.ipynb` — **RNN, LSTM y GRU**: tensor 3D `[samples, time_steps, features]`, *benchmarking* de arquitecturas (parámetros, tiempo, MSE), inferencia paso a paso y *adding problem* para evidenciar el desvanecimiento del gradiente.
- **Sesión 3:** `Sesiones/sesion3/sesion_3_espectrogramas_cnn.ipynb` — **Espectrogramas + CNN**: dataset sintético de audio de 3 clases (grave, agudo, barrido), STFT (`frame_length=255`, `frame_step=128`) → espectrograma `(124, 129, 1)`, visualización 2D/3D, CNN `Conv2D → MaxPooling2D → GlobalAveragePooling2D → Dropout → Dense(softmax)`, curvas de aprendizaje, matriz de confusión/F1, visualización de filtros, pooling a mano + fórmula de reducción, GAP vs. Flatten, Gradient Clipping en acción, Dropout entrenamiento vs. inferencia y diagnóstico con etiquetas aleatorias (memorización/sobreajuste).
- **Estilo de los notebooks:** teoría en Markdown + celdas de código reproducibles (semillas fijas: `np.random.seed` / `tf.random.set_seed`), gráficas interactivas con **Plotly** y salidas **no versionadas** (notebook *clean*).
- **Stack de DL:** **TensorFlow 2 / Keras 3**, elegido por su claridad académica y su API de capas recurrentes.

---

## 📁 Estructura Canónica del Repositorio

```
DL-Javeriana/
├── CONSTITUTION.md          # Verdad central del proyecto (este archivo)
├── README.md                # Puerta de entrada pública (badges, arquitectura, quickstart)
├── LICENSE                  # MIT — Copyright (c) 2026 Jan Polanco Velasco
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
├── slides.md              # Entry point maestro (menú hub + importa todas las sesiones)
├── package.json           # Dependencias Slidev (pnpm) — 1 solo lockfile
├── pnpm-lock.yaml         # Lock determinista compartido
├── components/            # Componentes Vue COMPARTIDOS
├── layouts/               # Layouts personalizados compartidos
├── public/                # Assets globales (logos, favicons, img/sesionN/ por deck)
├── global-bottom.vue      # Logos SIAM + Javeriana (automático en todo deck)
├── styles.css             # Estilos globales
├── setup.ts               # Config global (shortcuts, etc.)
└── pages/                 # Slides por sesión (importables vía src:)
    ├── sesion1.md         # Diapositivas Sesión 1 (id + routeAlias: sesion1)
    ├── sesion2.md         # Diapositivas Sesión 2 (id + routeAlias: sesion2)
    ├── sesion3.md         # Diapositivas Sesión 3 (id + routeAlias: sesion3)
    └── sesion4.md         # Diapositivas Sesión 4 (id + routeAlias: sesion4)
```

> **Regla:** Un **único** proyecto Slidev (`Slides/`) con **un solo** `package.json` y `pnpm-lock.yaml`. Cada sesión vive en `Slides/pages/sesionN.md` y se importa en `Slides/slides.md` vía `src: ./pages/sesionN.md`. Componentes, layouts, estilos y assets son compartidos. Los comandos Slidev se ejecutan desde el `Makefile` de la raíz (`make slidev-dev`, etc.).

> **Deploy:** PENDIENTE (evaluar Netlify/Vercel/GitHub Pages cuando los decks estén listos).

### Regla de Diagramas — Sin Mermaid por Defecto

> **REGLA OBLIGATORIA:** **No usar diagramas Mermaid por defecto** en diapositivas, README ni documentación del proyecto, **salvo que se solicite de forma explícita**.
>
> - Preferir **SVG vectoriales**, **componentes Vue interactivos** o **imágenes** cuando se necesite un diagrama.
> - Mermaid solo se permite si el usuario/tutor lo pide explícitamente en la petición.
> - Esta regla aplica a todo el repositorio (presentaciones, docs, README).

### Logos Institucionales (Obligatorio en Todo Deck)

> **REGLA:** Toda presentación Slidev del curso muestra los logos de **SIAM** y **Pontificia Universidad Javeriana Cali** en la esquina inferior derecha, vía `Slides/global-bottom.vue` (global automático). Variantes claro/oscuro en `Slides/public/img/logos/`. La portada de `slides.md` los muestra además en tamaño destacado.

### Estructura de Sesiones (Plantilla)

- Portada de sesión con `id: sesionN` **y** `routeAlias: sesionN` en el frontmatter (ver regla de navegación del menú).
- Frontmatter institucional obligatorio (ver sección Frontmatter).
- Animación progresiva con `v-click` / `v-clicks` (ver Reglas de Animación).
- Contenido en dos columnas (`layout: two-cols`) con componentes interactivos en la columna derecha cuando aplique.

### Navegación del Menú Hub (Obligatorio en Toda Sesión Nueva)

> **REGLA OBLIGATORIA:** todo `pages/sesionN.md` **debe** declarar `routeAlias: sesionN` en su frontmatter, junto al `id`:

```yaml
---
id: sesionN
routeAlias: sesionN
title: Sesión N - ...
---
```

**Por qué:** el `<HubNavCard to="/sesionN">` del menú en `slides.md` genera la ruta `/:no`. Slidev resuelve ese parámetro solo con **número de slide** o con **`frontmatter.routeAlias`** — el campo `id` **NO** sirve para navegación. Sin `routeAlias`, `/sesionN` no matchea y la navegación falla (parece que el menú no funciona o todo es secuencial).

**Alcance:** aplica a `sesion1`–`sesion4` (ya hechos) y a **cualquier sesión nueva** que se agregue a `slides.md` con `src: ./pages/sesionN.md` + `<HubNavCard to="/sesionN">`.

> **REGLA OBLIGATORIA (modo presenter):** el hub **NO** debe usar `<Link to="/sesionN">` crudo. Debe usar `<HubNavCard to="/sesionN">` (`Slides/components/HubNavCard.vue`), que antepone `/presenter` cuando `useNav().isPresenter` es verdadero — mismo patrón del `TocList` oficial de Slidev. Un `RouterLink` crudo a `/sesionN` clicado desde `/presenter/2` navega a `/sesion1` y **abandona la ruta `/presenter/*`**, matando la vista de presentador (notas, preview, controles).

### Reglas de HTML/SVG en Markdown (Evitar Errores de Compilación)

> **REGLA OBLIGATORIA:** en bloques HTML/SVG dentro de las diapositivas **no dejar líneas en blanco** entre tags contenedores (`<div>`, `<svg>`, `<span>`, etc.).

**Por qué:** markdown-it cierra el bloque HTML en cada línea en blanco (CommonMark type 6). Si tras el blanco hay indentación de 4+ espacios, el contenido se convierte en bloque de código (`<pre><code>`), se escapa el `<svg>` y queda un `</svg>` huérfano → error de Vue *Invalid end tag* (o *`<pre>` cannot be child of `<svg>`*).

**Patrón correcto (sin blancos dentro del árbol HTML):**

```html
<div class="h-full flex items-center justify-center">
<div class="relative w-[280px] h-[330px]">
  <svg viewBox="0 0 280 330">
  <defs>...</defs>
  <line ... />
  </svg>
</div>
</div>
```

**Verificación:** `pnpm -C Slides build` debe pasar (exit 0) antes de dar por buenas las slides.

### Regla de LaTeX — Nunca `$...$` Dentro de HTML Crudo (Evitar Fórmulas Muertas)

> **REGLA OBLIGATORIA:** las matemáticas `$...$` / `$$...$$` **solo compilan (KaTeX) dentro de contenido Markdown** — incluyendo el interior de `<v-click>` / `<v-clicks>`. **Dentro de tags HTML crudos** (`<div>`, `<p>`, `<li>`, `<span>` escritos a mano) el parser no las transforma y el `$` crudo llega a pantalla y al PDF.

**Casos reales corregidos (dictamen PDF):** `$\mathcal{L} + \lambda \sum w^2$` en tarjeta (S3 Botiquín), `$\max(R)$` y `$\frac{1}{|R|}$` en `<li>` crudos (S3 Max vs Average), `($n=3$)` en tarjeta (S1 NN-AR), `$(3 \times 3 \times 3)...$` en tarjeta y `($H \downarrow$)` en pie (S4).

**Reparación:** reescribir con texto/Unicode nativo (`max(R)`, `(1 / |R|) · Σ xᵢ`, `(H ↓, W ↓)`, `(n = 3)`, `λ · Σw²`) o sacar la fórmula fuera del tag HTML.

**Excepción exporter:** `magic-move` en vivo funciona, pero el PDF estático solo imprime el último paso salvo que se exporte con `--with-clicks` (ver `Makefile`: todos los targets `slidev-*-export` lo incluyen para que el material de estudio conserve la progresión).

---

### Reglas de Animación (v-click / v-clicks)

> **REGLA OBLIGATORIA:** todas las diapositivas del curso revelan su contenido progresivamente con los clics del presentador. Requiere `mdc: true` en el frontmatter global (ya está en `slides.md`).

1. **Título con `<v-click>`**: el H1 (y su `###` subtítulo asociado) se envuelve en `<v-click>`; aparece con el primer clic de la diapositiva.
2. **Listas con `<v-clicks>`**: cada bullet/elemento de la columna izquierda se revela con un clic individual dentro de `<v-clicks>`.
3. **Columna derecha con `<v-clicks>`**: todo lo que va tras `::right::` (mermaid, imágenes, bloques ASCII, placeholders) se envuelve en su propio `<v-clicks>`, de modo que la visual aparece después del texto.
4. **Tablas grandes sin animar**: las tablas de referencia (p. ej. Loss Functions, Funciones de Activación) NO se animan fila por fila; solo su título lleva `<v-click>` y la tabla queda visible con la diapositiva.
5. **Imágenes SOLO en markdown**: `![Texto descriptivo](/img/sesionN/imgN.jpg)` — **nunca** `<img>` HTML. Los assets viven en `Slides/public/img/sesionN/` y se referencian con ruta absoluta `/img/...`.

Patrón canónico de diapositiva `two-cols`:

```markdown
---
layout: two-cols
---

<v-click>

# Modelos Auto Regresivos

</v-click>

<v-clicks>

- Regresión Lineal
- Función de costo

</v-clicks>

::right::

<v-clicks>

![Taxonomía de algoritmos de Machine Learning](/img/sesion1/img49.jpg)

</v-clicks>
```

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
