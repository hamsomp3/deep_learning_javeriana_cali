---
id: sesion4
routeAlias: sesion4
title: Sesión 4 - Redes Neuronales Convolucionales (CNNs)
info: |
  ## Sesión 4: Redes Neuronales Convolucionales (CNNs)
  DEEP LEARNING
  Pontificia Universidad Javeriana Cali — Pregrado
  Semestre 2026-2 · Tutor: Jan Polanco Velasco
---

<v-click>

# <span class="bg-gradient-to-r from-teal-400 via-cyan-400 to-indigo-500 bg-clip-text text-transparent font-extrabold">Redes Neuronales Convolucionales</span>

</v-click>

<v-click>

### Filtros, convolución espacial, hiperparámetros y jerarquía visual

</v-click>

<v-click>

**Jan Polanco Velasco**

</v-click>

---
layout: default
---

<v-click>

# Hoja de Ruta de la Sesión

</v-click>

<v-click>

### Cuatro actos que construyen la visión artificial moderna

</v-click>

<div class="grid grid-cols-2 gap-4 mt-6">
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-indigo-500">01</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">De la Imagen al Tensor</div>
<div class="text-xs text-slate-500 mt-1">Píxeles, canales de color y por qué las redes densas (MLP) colapsan ante imágenes.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-teal-500">02</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">La Operación de Convolución 2D</div>
<div class="text-xs text-slate-500 mt-1">Filtros/kernels, detección de bordes y mapas de características (*feature maps*).</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-cyan-500">03</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Geometría de la Convolución</div>
<div class="text-xs text-slate-500 mt-1">Padding (*Valid vs. Same*), Stride y Convolución sobre tensores multicanal 3D.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-purple-500">04</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Pooling y Jerarquía de Abstracción</div>
<div class="text-xs text-slate-500 mt-1">Invarianza a traslaciones, campo receptivo y la arquitectura canónica en Keras.</div>
</div>
</div>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-indigo-500/25">01</div>

</v-click>

<v-click>

# De la Imagen al Tensor

</v-click>

<v-click>

### Representación matricial y el colapso de las redes densas (MLP)

</v-click>

---
layout: two-cols
---

<v-click>

# ¿Qué es una Imagen para una Máquina?

</v-click>

<v-click>

### Tensores discretos de intensidad

</v-click>

<v-clicks>

- **Escala de Grises (2D):** Una matriz de dimensiones $H \times W$, donde cada valor representa luminosidad:
  $$I(x, y) \in [0, 255] \quad (\text{o normalizado en } [0.0, 1.0])$$
- **Color RGB (3D):** Tres matrices apiladas en canales *(Rojo, Verde, Azul)*:
  $$\mathbf{X} \in \mathbb{R}^{H \times W \times 3}$$
- **La Vecindad Espacial:** Un píxel aislado carece de significado semántico; su valor solo tiene sentido en relación con sus **vecinos contiguos**.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-3 text-xs w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100 font-mono text-[11px] flex items-center justify-between">
<span>Estructura Tensor RGB:</span>
<span class="text-indigo-600 dark:text-indigo-400">[Alto, Ancho, Canales]</span>
</div>
<div class="flex items-center justify-center gap-3 py-3">
<div class="w-16 h-16 rounded-lg bg-rose-500/20 border-2 border-rose-500 flex flex-col items-center justify-center shadow-md">
<span class="text-rose-600 font-bold text-xs">Canal R</span>
<span class="text-[9px] text-slate-500">224×224</span>
</div>
<div class="w-16 h-16 rounded-lg bg-emerald-500/20 border-2 border-emerald-500 flex flex-col items-center justify-center shadow-md -ml-6 mt-4">
<span class="text-emerald-600 font-bold text-xs">Canal G</span>
<span class="text-[9px] text-slate-500">224×224</span>
</div>
<div class="w-16 h-16 rounded-lg bg-blue-500/20 border-2 border-blue-500 flex flex-col items-center justify-center shadow-md -ml-6 mt-8">
<span class="text-blue-600 font-bold text-xs">Canal B</span>
<span class="text-[9px] text-slate-500">224×224</span>
</div>
</div>
<p class="text-[11px] text-slate-500 leading-snug">
Una imagen típica de smartphone (12 MP) contiene más de <strong>36 millones de valores escalares</strong>.
</p>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

# El Dilema de la MLP en Visión

### ¿Por qué aplanar (*Flatten*) destruye la imagen?

<div class="text-[12px] leading-snug space-y-2 pr-2">

<v-clicks>

- **1. Pérdida de la Topología Espacial:**
  Al vectorizar una imagen $2D \to 1D$, el píxel $(x, y)$ pierde su cercanía física con $(x, y+1)$, destruyendo formas, texturas y contornos.
- **2. Explosión Inmanejable de Parámetros:**
  - Imagen modesta: $200 \times 200 \times 3 = 120.000$ entradas.
  - Primera capa oculta con $1.000$ neuronas:
    $$120.000 \times 1.000 = \mathbf{120 \text{ millones de pesos}}$$
  - Resultado: sobreajuste garantizado y lentitud extrema.
- **3. Cero Invarianza a Traslación:**
  Si un gato se desplaza 5 píxeles a la derecha, para una MLP es un vector totalmente nuevo y desconectado.

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-rose-50/80 dark:bg-rose-950/40 border border-rose-300 dark:border-rose-800 shadow-xl space-y-2 text-xs w-full select-none">
<div class="font-bold text-rose-900 dark:text-rose-200 flex items-center gap-1.5">
<span>⚠️</span> El Fracaso del "Flatten" en MLP
</div>
<div class="p-2.5 rounded-xl bg-white dark:bg-zinc-900 font-mono text-[10px] text-slate-600 dark:text-zinc-300 leading-relaxed border border-rose-200 dark:border-rose-900">
Matriz (3x3):<br>
[ A, B, C ]<br>
[ D, E, F ] ➔ Vector: [A, B, C, D, E, F, G, H, I]<br>
[ G, H, I ]<br>
<span class="text-rose-600 font-bold">¡B y E eran vecinos verticales, ahora están separados!</span>
</div>
<p class="text-[11px] text-slate-600 dark:text-zinc-300 leading-snug">
Necesitamos una operación que preserve la grilla bidimensional y aproveche la correlación local: la <strong>Convolución</strong>.
</p>
</div>
</div>

</v-clicks>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-teal-500/25">02</div>

</v-click>

<v-click>

# La Operación de Convolución 2D

</v-click>

<v-click>

### Filtros locales, detección de características y peso compartido

</v-click>

---
layout: two-cols
---

<v-click>

# La Mecánica del Kernel Convolucional

</v-click>

<div class="text-[12px] leading-snug space-y-1 pr-2">

<v-click>

### Producto punto deslizante

</v-click>

<v-clicks>

- **Kernel ($\mathbf{K}$):** matriz pequeña de pesos entrenables ($3 \times 3$ o $5 \times 5$).
- **Operación local:** superpone el filtro, multiplica elemento a elemento y suma + sesgo $b$:
  $$S(i,j) = (I * K)(i,j) = \sum_m \sum_n I_{i+m,j+n} K_{m,n} + b$$
- **Dos principios:**
  1. <span v-mark.underline.indigo="1">Conexiones locales:</span> cada neurona ve solo un parche diminuto.
  2. <span v-mark.circle.emerald="2">Pesos compartidos:</span> el mismo filtro barre **toda** la imagen.

</v-clicks>

</div>

::right::

<div class="h-full flex items-center justify-center pl-2">
<ConvolutionSimulator />
</div>

---
layout: two-cols
---

# Filtros Clásicos vs. Filtros Aprendidos

### De la visión artificial artesanal al Deep Learning

<div class="text-[12px] leading-snug space-y-2 pr-2">

<v-clicks>

- **Décadas de 1970 - 1990 (Ingeniería Manual):**
  Los investigadores pasaban años diseñando matrices fijas a mano para detectar bordes o esquinas:
  - **Sobel Horizontal:** Detecta cambios abruptos de brillo vertical.
  - **Sobel Vertical:** Detecta cambios de brillo horizontal.
- **La Revolución de las CNNs (LeCun, Krizhevsky):**
  - Los pesos del kernel **no se fijan a mano**.
  - Son parámetros libres inicializados aleatoriamente que se optimizan con **Backpropagation** y **Gradient Descent**.
  - La red descubre por sí misma cuáles son los detectores visuales óptimos para la tarea.

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-3 text-xs w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100 text-xs">Kernels Clásicos de Visión (Sobel):</div>
<div class="grid grid-cols-2 gap-2 text-center font-mono text-[10px]">
<div class="p-2.5 rounded-xl bg-slate-100 dark:bg-zinc-800 border border-slate-200 dark:border-zinc-700">
<div class="font-bold text-indigo-600 mb-1">Borde Vertical</div>
<div class="leading-tight">
[-1, 0, +1]<br>
[-2, 0, +2]<br>
[-1, 0, +1]
</div>
</div>
<div class="p-2.5 rounded-xl bg-slate-100 dark:bg-zinc-800 border border-slate-200 dark:border-zinc-700">
<div class="font-bold text-teal-600 mb-1">Borde Horizontal</div>
<div class="leading-tight">
[+1, +2, +1]<br>
[ 0,  0,  0]<br>
[-1, -2, -1]
</div>
</div>
</div>
<div class="p-2 rounded-lg bg-indigo-50 dark:bg-indigo-950/40 text-[11px] text-indigo-900 dark:text-indigo-200 leading-tight">
En una capa `Conv2D(32, 3)`, la red aprende simultáneamente <strong>32 filtros distintos</strong> como estos en paralelo.
</div>
</div>
</div>

</v-clicks>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-cyan-500/25">03</div>

</v-click>

<v-click>

# Geometría de la Convolución

</v-click>

<v-click>

### Padding, Stride y Convolución sobre Volúmenes 3D

</v-click>

---
layout: two-cols
---

<v-click>

# El Efecto de Reducción y el Padding

</v-click>

<div class="text-[12px] leading-snug space-y-1 pr-2">

<v-click>

### Protegiendo los bordes de la imagen

</v-click>

<v-clicks>

- **La convolución cruda encoge:** $N \times N$ con kernel $f \times f$ da:
  $$O = N - f + 1 \quad (5 \times 5, f = 3 \to \mathbf{3 \times 3})$$
- Las esquinas participan una sola vez: se pierde información perimetral.
- **Solución: Padding ($p$)** con ceros (*Zero Padding*):
  1. <span v-mark.underline.orange="1">Valid ($p = 0$):</span> sin relleno, encoge.
  2. <span v-mark.circle.emerald="2">Same:</span> $p = \frac{f-1}{2}$ ceros, la salida conserva el tamaño.

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-2 text-xs w-full select-none text-center">
<div class="font-bold text-slate-700 dark:text-zinc-200 mb-1">Same Padding (Filtro 3×3, p=1)</div>
<div class="inline-block p-2 bg-slate-100 dark:bg-zinc-800 rounded-xl border border-slate-300 dark:border-zinc-700 font-mono text-[9px] leading-tight">
<span class="text-slate-400">0  0  0  0  0  0  0</span><br>
<span class="text-slate-400">0</span>  <strong class="text-indigo-600">X  X  X  X  X</strong>  <span class="text-slate-400">0</span><br>
<span class="text-slate-400">0</span>  <strong class="text-indigo-600">X  X  X  X  X</strong>  <span class="text-slate-400">0</span><br>
<span class="text-slate-400">0</span>  <strong class="text-indigo-600">X  X  X  X  X</strong>  <span class="text-slate-400">0</span><br>
<span class="text-slate-400">0</span>  <strong class="text-indigo-600">X  X  X  X  X</strong>  <span class="text-slate-400">0</span><br>
<span class="text-slate-400">0</span>  <strong class="text-indigo-600">X  X  X  X  X</strong>  <span class="text-slate-400">0</span><br>
<span class="text-slate-400">0  0  0  0  0  0  0</span>
</div>
<p class="text-[11px] text-slate-500 mt-2 leading-snug">
La cuadrícula de ceros (en gris) permite centrar el filtro en los bordes originales sin perder resolución espacial.
</p>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

# Stride y la Ecuación Dimensional Universal

### ¿A qué velocidad se desplaza el kernel?

<div class="text-[12px] leading-snug space-y-2 pr-2">

<v-clicks>

- **Stride ($s$):** El tamaño del salto que da el kernel en cada paso (horizontal y vertical).
  - $s = 1$: Paso suave, máxima cobertura y resolución.
  - $s = 2$: Salta de 2 en 2 píxeles, reduciendo el mapa a la **mitad** de su tamaño (submuestreo incorporado).
- **Fórmula de Dimensionalidad Universal:**
  $$O = \left\lfloor \frac{N + 2p - f}{s} \right\rfloor + 1$$
- **Ejemplo Práctico:**
  - Entrada: $N = 28$ (MNIST)
  - Filtro: $f = 3$ | Padding: $p = 1$ (*same*) | Stride: $s = 2$
  $$O = \left\lfloor \frac{28 + 2(1) - 3}{2} \right\rfloor + 1 = \left\lfloor \frac{27}{2} \right\rfloor + 1 = 13 + 1 = \mathbf{14}$$

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-5 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-3 text-xs w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100 flex items-center justify-between">
<span>Efecto del Stride</span>
<span class="text-[10px] px-2 py-0.5 rounded bg-indigo-100 dark:bg-indigo-950 text-indigo-600 font-mono">Control Espacial</span>
</div>
<div class="space-y-2 text-[11px]">
<div class="p-2 rounded-lg bg-slate-50 dark:bg-zinc-800 border border-slate-200 dark:border-zinc-700">
<div class="font-bold text-slate-700 dark:text-zinc-200">Stride = 1:</div>
<div class="text-slate-500">Mantiene el detalle denso de las texturas. Es el estándar en las primeras capas.</div>
</div>
<div class="p-2 rounded-lg bg-slate-50 dark:bg-zinc-800 border border-slate-200 dark:border-zinc-700">
<div class="font-bold text-slate-700 dark:text-zinc-200">Stride ≥ 2 (Strided Convolutions):</div>
<div class="text-slate-500">Alternativa moderna y aprendible a las capas de Pooling para comprimir dimensiones.</div>
</div>
</div>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

# Convolución en Volúmenes 3D

### Múltiples canales de entrada y múltiples filtros de salida

<div class="text-[12px] leading-snug space-y-2 pr-2">

<v-clicks>

- **Los canales del filtro DEBEN coincidir con la entrada:**
  Si la entrada es una imagen RGB ($H \times W \times \mathbf{3}$), cada filtro individual tiene volumen:
  $$\mathbf{K}_i \in \mathbb{R}^{f \times f \times \mathbf{3}}$$
- **Cada filtro produce UN SOLO mapa 2D:**
  Se convoluciona cada canal 2D por separado, se suman los 3 resultados punto a punto y se añade un sesgo escalar $b_i$.
- **Banco de $K$ Filtros:**
  Si usamos $K$ filtros distintos en una capa:
  $$\text{Entrada } (H \times W \times C) \xrightarrow{K \text{ filtros}} \text{Salida } (H' \times W' \times \mathbf{K})$$
- La profundidad de la salida **no depende** del número de canales originales, sino de cuántos filtros configuramos en Keras.

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-2 text-xs w-full select-none text-center">
<div class="font-bold text-slate-800 dark:text-zinc-100 text-xs">Transformación de Volúmenes:</div>
<div class="flex items-center justify-center gap-2 py-3 text-[10px] font-mono">
<div class="p-2 rounded-lg bg-blue-50 dark:bg-blue-950/60 border border-blue-200">
Entrada:<br>
<strong class="text-blue-600">32 × 32 × 3</strong>
</div>
<span class="font-bold text-slate-400">➔</span>
<div class="p-2 rounded-lg bg-indigo-50 dark:bg-indigo-950/60 border border-indigo-200">
16 Filtros:<br>
<strong class="text-indigo-600">3 × 3 × 3</strong>
</div>
<span class="font-bold text-slate-400">➔</span>
<div class="p-2 rounded-lg bg-rose-50 dark:bg-rose-950/60 border border-rose-200">
Salida:<br>
<strong class="text-rose-600">32 × 32 × 16</strong>
</div>
</div>
<div class="p-2 rounded-lg bg-slate-100 dark:bg-zinc-800 font-mono text-[10px] text-slate-600 dark:text-zinc-300">
Total parámetros por filtro: (3 × 3 × 3) + 1 bias = 28<br>
Capa completa (16 filtros): 28 × 16 = <strong>448 parámetros</strong>
</div>
</div>
</div>

</v-clicks>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-purple-500/25">04</div>

</v-click>

<v-click>

# Pooling, Jerarquía y Arquitectura CNN

</v-click>

<v-click>

### Invarianza espacial, campo receptivo y el flujo completo

</v-click>

---
layout: two-cols
---

# Capas de Pooling (Submuestreo)

### Resumiendo la presencia de características

<div class="text-[12px] leading-snug space-y-2 pr-2">

<v-clicks>

- **Objetivo:** Reducir agresivamente el ancho y alto del tensor sin modificar la cantidad de canales.
- **Max Pooling ($2 \times 2, s=2$):**
  - Toma el valor más alto en cada bloque $2 \times 2$.
  - Pregunta semántica: *"¿Estuvo presente esta característica en la región?"*
  - Reduce el área espacial en un **75%** (cada lado a la mitad).
- **Propiedad Fundamental: Invarianza Local a Traslaciones:**
  Si un borde o textura se mueve 1 o 2 píxeles dentro de la ventana de pooling, el valor máximo resultante **permanece idéntico**.
- **Ventaja adicional:** No añade ningún parámetro entrenable a la red.

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-3 text-xs w-full select-none text-center">
<div class="font-bold text-slate-800 dark:text-zinc-100 text-xs">Mecánica de Max Pooling 2×2 (Stride 2):</div>
<div class="flex items-center justify-center gap-3">
<div class="grid grid-cols-2 gap-1 p-1.5 bg-slate-100 dark:bg-zinc-800 rounded-lg font-mono text-[9px]">
<div class="p-1 rounded bg-rose-100 dark:bg-rose-950 text-rose-800 font-bold">12 &nbsp; 20<br>8 &nbsp;&nbsp; 14</div>
<div class="p-1 rounded bg-blue-100 dark:bg-blue-950 text-blue-800 font-bold">30 &nbsp;&nbsp; 0<br>2 &nbsp;&nbsp; 18</div>
<div class="p-1 rounded bg-emerald-100 dark:bg-emerald-950 text-emerald-800 font-bold">80 &nbsp; 45<br>32 &nbsp; 10</div>
<div class="p-1 rounded bg-amber-100 dark:bg-amber-950 text-amber-800 font-bold">5 &nbsp;&nbsp; 95<br>15 &nbsp; 70</div>
</div>
<span class="font-bold text-indigo-600 text-base">➔</span>
<div class="grid grid-cols-2 gap-1 p-1.5 bg-indigo-50 dark:bg-indigo-950/60 rounded-lg font-mono text-xs font-bold border border-indigo-200 dark:border-indigo-800">
<div class="p-1.5 rounded bg-rose-500 text-white">20</div>
<div class="p-1.5 rounded bg-blue-500 text-white">30</div>
<div class="p-1.5 rounded bg-emerald-500 text-white">80</div>
<div class="p-1.5 rounded bg-amber-500 text-white">95</div>
</div>
</div>
<div class="text-[11px] text-slate-500 leading-snug">
Se conserva el valor dominante de cada cuadrante eliminando detalles irrelevantes de fondo.
</div>
</div>
</div>

</v-clicks>

---
layout: default
---

<v-click>

# La Jerarquía de Características Visuales

</v-click>

<v-click>

### Cómo "ve" el mundo una red neuronal convolucional profunda

</v-click>

<div class="grid grid-cols-3 gap-5 mt-6 select-none">
<div v-click class="p-5 rounded-2xl bg-white/70 dark:bg-zinc-900/70 border border-slate-200 dark:border-zinc-800 shadow-xl flex flex-col justify-between">
<div>
<div class="text-indigo-600 dark:text-indigo-400 font-bold text-base mb-1 flex items-center gap-1.5">
<span>📐</span> Capas Iniciales
</div>
<div class="text-xs font-bold text-slate-700 dark:text-zinc-200 mb-2">Características Primitivas</div>
<ul class="text-xs text-slate-600 dark:text-zinc-300 space-y-2 list-disc pl-4">
<li>Bordes orientados (verticales, diagonales).</li>
<li>Gradientes de luz y sombras.</li>
<li>Parches simples de color uniforme.</li>
</ul>
</div>
<div class="text-[11px] font-mono text-slate-400 mt-3 pt-2 border-t border-slate-200 dark:border-zinc-800">
Campo Receptivo: Pequeño (Local)
</div>
</div>
<div v-click class="p-5 rounded-2xl bg-white/70 dark:bg-zinc-900/70 border border-slate-200 dark:border-zinc-800 shadow-xl flex flex-col justify-between">
<div>
<div class="text-teal-600 dark:text-teal-400 font-bold text-base mb-1 flex items-center gap-1.5">
<span>🧩</span> Capas Intermedias
</div>
<div class="text-xs font-bold text-slate-700 dark:text-zinc-200 mb-2">Partes de Objetos y Texturas</div>
<ul class="text-xs text-slate-600 dark:text-zinc-300 space-y-2 list-disc pl-4">
<li>Combinación de bordes: curvas, esquinas.</li>
<li>Texturas repetitivas (rayas, mallas).</li>
<li>Partes anatómicas: ojos, narices, ruedas.</li>
</ul>
</div>
<div class="text-[11px] font-mono text-teal-600 dark:text-teal-400 mt-3 pt-2 border-t border-slate-200 dark:border-zinc-800">
Campo Receptivo: Mediano
</div>
</div>
<div v-click class="p-5 rounded-2xl bg-gradient-to-br from-indigo-500/10 to-purple-500/10 border border-indigo-200 dark:border-indigo-900/60 shadow-xl flex flex-col justify-between">
<div>
<div class="text-purple-600 dark:text-purple-400 font-bold text-base mb-1 flex items-center gap-1.5">
<span>🚗</span> Capas Profundas
</div>
<div class="text-xs font-bold text-slate-700 dark:text-zinc-200 mb-2">Conceptos Semánticos Globales</div>
<ul class="text-xs text-slate-600 dark:text-zinc-300 space-y-2 list-disc pl-4">
<li>Rostros humanos completos.</li>
<li>Siluetas de vehículos, animales, muebles.</li>
<li>Representaciones de alta abstracción listas para clasificar.</li>
</ul>
</div>
<div class="text-[11px] font-semibold text-purple-700 dark:text-purple-300 mt-3">
Campo Receptivo: Global (Toda la imagen)
</div>
</div>
</div>

---
layout: default
---

<v-click>

# Anatomía de la Arquitectura Canónica CNN

</v-click>

<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl my-4 text-xs font-mono select-none">
<div class="flex items-center justify-between gap-2 text-center">
<div class="p-3 rounded-xl bg-blue-50 dark:bg-blue-950/40 border border-blue-200 flex-1">
<div class="font-bold text-blue-700 dark:text-blue-300 text-xs">Entrada</div>
<div class="text-[10px] text-slate-500 mt-1">224 × 224 × 3</div>
<div class="text-[9px] text-blue-600 mt-2 font-sans">Píxeles crudos</div>
</div>
<span class="text-slate-400 font-bold">➔</span>
<div class="p-3 rounded-xl bg-indigo-50 dark:bg-indigo-950/40 border border-indigo-200 flex-[2]">
<div class="font-bold text-indigo-700 dark:text-indigo-300 text-xs">Extracción de Características (*Feature Extractor*)</div>
<div class="text-[10px] text-slate-500 mt-1">[Conv2D + ReLU + MaxPool] × N</div>
<div class="text-[9px] text-indigo-600 mt-2 font-sans">El alto/ancho disminuye mientras los canales aumentan (3 ➔ 32 ➔ 64 ➔ 128)</div>
</div>
<span class="text-slate-400 font-bold">➔</span>
<div class="p-3 rounded-xl bg-teal-50 dark:bg-teal-950/40 border border-teal-200 flex-1">
<div class="font-bold text-teal-700 dark:text-teal-300 text-xs">Transición</div>
<div class="text-[10px] text-slate-500 mt-1">Flatten / GAP</div>
<div class="text-[9px] text-teal-600 mt-2 font-sans">Vector 1D denso</div>
</div>
<span class="text-slate-400 font-bold">➔</span>
<div class="p-3 rounded-xl bg-rose-50 dark:bg-rose-950/40 border border-rose-200 flex-1">
<div class="font-bold text-rose-700 dark:text-rose-300 text-xs">Clasificador (*Head*)</div>
<div class="text-[10px] text-slate-500 mt-1">Dense + Softmax</div>
<div class="text-[9px] text-rose-600 mt-2 font-sans">Probabilidades (K clases)</div>
</div>
</div>
</div>

<div class="text-xs text-slate-600 dark:text-zinc-300 space-y-1 mt-4">
<p><strong>Regla de Diseño Estándar:</strong> A medida que la red profundiza, la resolución espacial disminuye (H ↓, W ↓) mediante MaxPooling, mientras que la riqueza semántica aumenta incrementando los filtros (C ↑).</p>
</div>

---

<v-click>

# Implementación en Keras con Shiki Magic Move

</v-click>

````md magic-move
```python
# Paso 1: Configurar la capa de entrada convolucional
model = Sequential([
    Input(shape=(28, 28, 1)),
    Conv2D(filters=32, kernel_size=(3, 3), activation='relu', padding='same')
])
```
```python
# Paso 2: Agregar compresión espacial con Max Pooling
model = Sequential([
    Input(shape=(28, 28, 1)),
    Conv2D(filters=32, kernel_size=(3, 3), activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2, 2)), # Reduce de 28x28 a 14x14
    Conv2D(filters=64, kernel_size=(3, 3), activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2, 2))  # Reduce de 14x14 a 7x7
])
```
```python
# Paso 3: Conectar el extractor con el clasificador denso
model = Sequential([
    Input(shape=(28, 28, 1)),
    Conv2D(filters=32, kernel_size=(3, 3), activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2, 2)),
    Conv2D(filters=64, kernel_size=(3, 3), activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2, 2)),
    Flatten(),                      # Vectoriza 7 x 7 x 64 = 3.136 características
    Dropout(0.4),                   # Regularización contra overfitting
    Dense(128, activation='relu'),
    Dense(10, activation='softmax') # 10 clases de salida
])
```
```python
# Paso 4: Compilación y optimización
model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
    loss='categorical_crossentropy',
    metrics=['accuracy']
)
model.summary()
```
````

---
class: text-center
---

<v-click>

# 🛠️ Laboratorio Práctico de la Sesión 4

</v-click>

<v-click>

### Clasificación de Imágenes y Extracción de Mapas de Activación

</v-click>

<div class="max-w-xl mx-auto mt-6 p-6 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-2xl text-left text-sm space-y-4">
<div v-click class="flex items-center gap-3">
<div class="w-10 h-10 rounded-xl bg-blue-100 dark:bg-blue-950 flex items-center justify-center text-blue-600 text-xl font-bold">1</div>
<div>
<div class="font-bold">Visualización de Convoluciones Manuales</div>
<div class="text-xs text-slate-500">Aplicación de filtros Sobel y Laplaciano con NumPy y OpenCV en imágenes reales.</div>
</div>
</div>
<div v-click class="flex items-center gap-3">
<div class="w-10 h-10 rounded-xl bg-indigo-100 dark:bg-indigo-950 flex items-center justify-center text-indigo-600 text-xl font-bold">2</div>
<div>
<div class="font-bold">Entrenamiento de una CNN en Keras</div>
<div class="text-xs text-slate-500">Construcción de arquitectura Conv2D + BatchNorm + MaxPooling sobre CIFAR-10 / Fashion-MNIST.</div>
</div>
</div>
<div v-click class="flex items-center gap-3">
<div class="w-10 h-10 rounded-xl bg-purple-100 dark:bg-purple-950 flex items-center justify-center text-purple-600 text-xl font-bold">3</div>
<div>
<div class="font-bold">Inspección de Feature Maps Internos</div>
<div class="text-xs text-slate-500">Extracción y visualización de lo que las neuronas aprendieron en cada capa intermedia.</div>
</div>
</div>
</div>

---
layout: default
class: text-center
---

<v-click>

# Lo que aprendimos hoy

</v-click>

<div class="grid grid-cols-2 gap-4 mt-6 max-w-3xl mx-auto text-left">
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-indigo-600 dark:text-indigo-400 text-sm">Topología Espacial</div>
<div class="text-xs text-slate-500 mt-1">Aplanar una imagen destruye la vecindad. Las CNNs preservan la grilla y reducen millones de parámetros gracias a los pesos compartidos.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-teal-600 dark:text-teal-400 text-sm">Convolución y Filtros</div>
<div class="text-xs text-slate-500 mt-1">El kernel realiza un producto punto local. La red aprende los filtros automáticamente mediante descenso de gradiente.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-cyan-600 dark:text-cyan-400 text-sm">Padding y Stride</div>
<div class="text-xs text-slate-500 mt-1">El padding protege los bordes y preserva dimensiones (*same*), mientras que el stride controla la tasa de salto espacial.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-purple-600 dark:text-purple-400 text-sm">Pooling y Jerarquía</div>
<div class="text-xs text-slate-500 mt-1">Max Pooling aporta invarianza a pequeñas traslaciones. Las capas tempranas detectan bordes y las profundas ensamblan objetos complejos.</div>
</div>
</div>

<v-click>

<div class="mt-8 opacity-70">
DEEP LEARNING · Pontificia Universidad Javeriana Cali<br>
<strong>Jan Polanco Velasco</strong>
</div>

</v-click>
