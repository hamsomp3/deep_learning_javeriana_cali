---
id: sesion2
routeAlias: sesion2
title: Sesión 2 - Redes Neuronales Recurrentes (RNN, LSTM y GRU)
info: |
  ## Sesión 2: Redes Neuronales Recurrentes (RNN, LSTM y GRU)
  DEEP LEARNING
  Pontificia Universidad Javeriana Cali — Pregrado
  Semestre 2026-2 · Tutor: Jan Polanco Velasco
---

<v-click>

# Redes Neuronales Recurrentes

</v-click>

<v-click>

**Modelando dependencias temporales y secuencias complejas (RNN, LSTM, GRU)**

</v-click>

<v-click>

**Jan Polanco Velasco**

</v-click>

---
layout: two-cols
---

<v-click>

# ¿Por qué el orden importa?

</v-click>

<v-click>

### El problema de la "Bolsa de Palabras" (*Bag of Words*)

</v-click>

<v-clicks>

- Consideremos la siguiente oración incompleta:
  <div class="p-3 my-2 rounded-xl bg-slate-100 dark:bg-zinc-800 text-base font-serif italic text-center">
    "El gato se comió el <span v-mark.underline.orange="1">______</span>"
  </div>
- ¿Cómo sabe un modelo si sigue <span v-mark.circle.emerald="2">"pescado"</span> y no *"avión"*?
- **Las redes densas (MLP) tradicionales:**
  - Tratan las entradas como un saco desordenado de características ($i.i.d.$).
  - Pierden completamente la sintaxis, el contexto y la <span v-mark.highlight.yellow="3">estructura temporal</span>.
- En secuencias reales (texto, audio, finanzas), **la posición de cada elemento altera el significado**.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-5 rounded-2xl bg-white/70 dark:bg-zinc-900/70 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-4 text-xs select-none w-full">
  <div class="font-bold text-slate-700 dark:text-zinc-200">Mismo conjunto de palabras, significado opuesto:</div>
  <div class="p-3 rounded-xl bg-emerald-50 dark:bg-emerald-950/40 border border-emerald-300 dark:border-emerald-800 text-emerald-900 dark:text-emerald-200 font-serif">
    1. "No estaba mal, estaba <strong>excelente</strong>." ➔ <span class="font-bold">Positivo (+1)</span>
  </div>
  <div class="p-3 rounded-xl bg-rose-50 dark:bg-rose-950/40 border border-rose-300 dark:border-rose-800 text-rose-900 dark:text-rose-200 font-serif">
    2. "No estaba excelente, estaba <strong>mal</strong>." ➔ <span class="font-bold">Negativo (-1)</span>
  </div>
  <div class="text-[11px] text-slate-500 leading-snug">
    Una red densa cuenta las palabras idénticas y arroja la misma predicción. Una <strong>RNN</strong> procesa palabra por palabra manteniendo un vector de memoria interna.
  </div>
</div>
</div>

</v-clicks>
---
layout: two-cols
---

<v-click>

# La Neurona Recurrente Básica

</v-click>

<v-click>

### Desenrollado Temporal (*Unfolding through time*)

</v-click>

<v-clicks>

- **Vector de Estado Oculto ($h_t$):** Representa la memoria acumulada hasta el instante $t$.
- **Condición inicial:** En el instante cero, <span v-mark.box.blue="1">$h_0 = \mathbf{0}$</span> *(sin recuerdos previos)*.
- **Ecuaciones fundamentales en cada paso $t$:**
  $$h_t = \tanh\left( W_{hh} h_{t-1} + W_{xh} x_t + b_h \right)$$
  $$\hat{y}_t = g\left( W_{hy} h_t + b_y \right)$$
- **Pesos compartidos:** Las matrices $W_{xh}, W_{hh}, W_{hy}$ son **las mismas** en cada paso del tiempo.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl select-none text-center">
  <div class="text-xs font-mono text-slate-500 mb-2 font-bold">Unfolded RNN (Paso a Paso):</div>
  <svg viewBox="0 0 280 240" class="w-[280px] h-[240px]">
  <defs>
  <marker id="rnn-arr" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
  <path d="M 0 2 L 7 5 L 0 8 z" class="fill-slate-700 dark:fill-zinc-300" />
  </marker>
  </defs>
  <text x="140" y="25" text-anchor="middle" class="font-serif italic text-xs font-bold fill-slate-500">h₀ = 0</text>
  <line x1="140" y1="32" x2="140" y2="60" class="stroke-slate-700 dark:stroke-zinc-300" stroke-width="2" marker-end="url(#rnn-arr)" />
  <circle cx="50" cy="80" r="16" fill="#bbf7d0" stroke="#166534" stroke-width="2" />
  <text x="50" y="85" text-anchor="middle" class="font-serif italic text-xs">x₁</text>
  <line x1="68" y1="80" x2="118" y2="80" class="stroke-slate-700 dark:stroke-zinc-300" stroke-width="2" marker-end="url(#rnn-arr)" />
  <rect x="120" y="65" width="40" height="30" rx="6" fill="#e0e7ff" stroke="#4f46e5" stroke-width="2" />
  <text x="140" y="84" text-anchor="middle" class="font-serif italic text-xs font-bold text-indigo-900">h₁</text>
  <line x1="162" y1="80" x2="212" y2="80" class="stroke-slate-700 dark:stroke-zinc-300" stroke-width="2" marker-end="url(#rnn-arr)" />
  <circle cx="230" cy="80" r="16" fill="#fecdd3" stroke="#9f1239" stroke-width="2" />
  <text x="230" y="85" text-anchor="middle" class="font-serif italic text-xs">ŷ₁</text>
  <line x1="140" y1="98" x2="140" y2="135" class="stroke-indigo-600" stroke-width="2" marker-end="url(#rnn-arr)" />
  <circle cx="50" cy="155" r="16" fill="#bbf7d0" stroke="#166534" stroke-width="2" />
  <text x="50" y="160" text-anchor="middle" class="font-serif italic text-xs">x₂</text>
  <line x1="68" y1="155" x2="118" y2="155" class="stroke-slate-700 dark:stroke-zinc-300" stroke-width="2" marker-end="url(#rnn-arr)" />
  <rect x="120" y="140" width="40" height="30" rx="6" fill="#e0e7ff" stroke="#4f46e5" stroke-width="2" />
  <text x="140" y="159" text-anchor="middle" class="font-serif italic text-xs font-bold text-indigo-900">h₂</text>
  <line x1="162" y1="155" x2="212" y2="155" class="stroke-slate-700 dark:stroke-zinc-300" stroke-width="2" marker-end="url(#rnn-arr)" />
  <circle cx="230" cy="155" r="16" fill="#fecdd3" stroke="#9f1239" stroke-width="2" />
  <text x="230" y="160" text-anchor="middle" class="font-serif italic text-xs">ŷ₂</text>
  <text x="140" y="210" text-anchor="middle" class="font-bold text-lg fill-slate-400">⋮</text>
  </svg>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# Anatomía Interna de la RNN

</v-click>

<div class="text-[12px] leading-snug space-y-2 pr-2">

<v-click>

### Zoom al paso temporal $t=2$: ¿Qué hay dentro de $h_2$?

</v-click>

<v-clicks>

- **La celda recurrente no es un escalar:** Es una **capa densa (*Fully Connected*)** compuesta por $M$ neuronas ocultas.
- **Entradas simultáneas:** La capa $h_2$ recibe dos fuentes de información:
  1. <span v-mark.underline.green="1">La memoria previa ($h_1 \in \mathbb{R}^M$)</span> ponderada por la matriz $W^{(h,h)}$.
  2. <span v-mark.underline.blue="2">La entrada actual ($x_2 \in \mathbb{R}^P$)</span> ponderada por la matriz $W^{(h,x)}$.
- **Ecuación escalar por cada neurona $m$:**
  $$h_{2,m} = g\left( \sum_{k=1}^M w_{m,k}^{(h,h)} h_{1,k} + \sum_{p=1}^P w_{m,p}^{(h,x)} x_{2,p} + b_h \right)$$
- **Generación de la predicción $\hat{y}_2$:**
  Las $M$ activaciones se combinan mediante $W^{(y,h)}$ para emitir la salida:
  $$\hat{y}_2 = g\left( \sum_{m=1}^M w_m^{(y,h)} h_{2,m} + b_y \right)$$

</v-clicks>

</div>

::right::

<div class="h-full flex items-center justify-center pl-2">
  <RnnCellZoom />
</div>

---
layout: two-cols
---

<v-click>

# Patrones de Uso en Secuencias

</v-click>

<v-click>

### Taxonomía de Arquitecturas Recurrentes

</v-click>

<v-clicks>

- **Many-to-One:** Secuencia de entrada ➔ Una sola predicción al final *(Análisis de sentimientos, clasificación de audios)*.
- **One-to-Many:** Una sola entrada semilla ➔ Secuencia completa de salida *(Generación de música, subtitulado de imágenes)*.
- **Many-to-Many Sincronizado ($T_x = T_y$):** Salida por cada instante de entrada *(POS Tagging gramatical, predicción de series)*.
- **Many-to-Many Asíncrono ($T_x \neq T_y$):** Modelo Encoder-Decoder *(Traducción de idiomas, resumidores automáticos)*.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2">
<RnnArchitectures />
</div>

</v-clicks>
---
layout: two-cols
---

<v-click>

# El Talón de Aquiles de la RNN Simple

</v-click>

<v-click>

### Desvanecimiento del Gradiente (*Vanishing Gradient*)

</v-click>

<v-clicks>

- **Backpropagation Through Time (BPTT):** Para ajustar los pesos, el gradiente debe retroceder multiplicándose en cada paso temporal:
  $$\frac{\partial \mathcal{L}_T}{\partial h_1} = \frac{\partial \mathcal{L}_T}{\partial h_T} \prod_{j=2}^T \frac{\partial h_j}{\partial h_{j-1}}$$
- **El producto sucesivo de derivadas:**
  - Si los eigenvalores de $W_{hh} < 1$ o la derivada de $\tanh < 1$, el gradiente se atenúa exponencialmente hacia **cero**.

</v-clicks>

::right::


<v-clicks>

- **Consecuencia práctica:**
  - La red sufre de **amnesia a corto plazo**: no recuerda palabras o datos vistos hace más de 8 o 10 pasos atrás.

</v-clicks>

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-5 rounded-2xl bg-rose-50/80 dark:bg-rose-950/40 border border-rose-300 dark:border-rose-800 shadow-xl text-xs select-none w-full space-y-3">
  <div class="font-bold text-rose-900 dark:text-rose-200 text-sm flex items-center gap-1.5">
  <span>⚠️</span> Pérdida de Dependencias a Largo Plazo
  </div>
  <div class="p-3 bg-white dark:bg-zinc-900 rounded-xl border border-rose-200 dark:border-zinc-800 font-serif text-[11px] leading-relaxed">
    "Los <strong>perros</strong> que vi corriendo por el parque detrás de los niños durante aquella fría tarde de invierno en Bogotá <span v-mark.circle.red="1">[ estaban / estaba ]</span> cansados."
  </div>
  <p class="text-slate-600 dark:text-zinc-300 leading-normal">
    Para cuando la RNN llega al verbo final, la influencia del gradiente del sujeto plural <em>("Los perros")</em> se ha desvanecido por completo.
  </p>
</div>
</div>
</v-clicks>

---
layout: two-cols
---

<v-click>

# LSTM (Long Short-Term Memory)

</v-click>

<div class="text-[13px] leading-snug space-y-1.5 pr-2">

<v-click>

### Hochreiter & Schmidhuber (1997)

</v-click>

<v-clicks>

- **La Celda de Memoria:** Diseñada explícitamente para mantener información a través de cientos de pasos.
- **La Autopista de Estado Celular ($C_t$):**
  - Flujo de información lineal con muy pocas transformaciones no lineales.
  - El gradiente fluye hacia atrás mediante sumas sin desvanecerse.
- **Las 3 Compuertas Moduladoras ($\sigma$):**
  1. **Compuerta de Olvido ($f_t$):** Qué descartar del pasado.
  2. **Compuerta de Entrada ($i_t$):** Qué nuevo conocimiento registrar.
  3. **Compuerta de Salida ($o_t$):** Qué enviar al estado oculto actual $h_t$.

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center transform scale-85 origin-center">
  <LstmCell />
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# GRU: Gated Recurrent Unit

</v-click>

<v-click>

### Cho et al. (2014) — La alternativa simplificada

</v-click>

<v-clicks>

- **Motivación:** LSTM es potente pero costosa en cómputo (4 matrices de pesos por celda).
- **Fusión de estados:** Unifica el estado celular $C_t$ y el estado oculto $h_t$ en una sola variable: <span v-mark.underline.orange="1">$h_t$</span>.
- **Solo 2 compuertas principales:**
  - **$\Gamma_u$ (*Update Gate*):** Decide si conservar el estado anterior o actualizarlo.
  - **$\Gamma_r$ (*Reset Gate*):** Decide qué tanto del estado anterior influye en el nuevo candidato $\tilde{h}_t$.
- **Actualización convexa elegante:**
  $$h_t = (1 - \Gamma_u) \odot h_{t-1} + \Gamma_u \odot \tilde{h}_t$$

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-5 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl text-xs space-y-3 select-none w-full">
  <div class="font-bold text-slate-800 dark:text-zinc-200 flex items-center justify-between">
  <span>LSTM vs. GRU</span>
  <span class="text-xs px-2 py-0.5 rounded-full bg-amber-100 text-amber-800 font-normal">Eficiencia</span>
  </div>
  <div class="grid grid-cols-2 gap-2 text-center">
  <div class="p-3 rounded-xl bg-slate-100 dark:bg-zinc-800 border border-slate-200 dark:border-zinc-700">
  <div class="font-bold text-indigo-600">LSTM</div>
  <div class="text-[11px] text-slate-500 mt-1">3 Compuertas (f, i, o)</div>
  <div class="text-[11px] text-slate-500">2 Estados (c, h)</div>
  <div class="text-xs font-bold text-slate-700 dark:text-zinc-300 mt-2">4 × d² Parámetros</div>
  </div>
  <div class="p-3 rounded-xl bg-emerald-50 dark:bg-emerald-950/40 border border-emerald-300 dark:border-emerald-800">
  <div class="font-bold text-emerald-600">GRU</div>
  <div class="text-[11px] text-slate-500 mt-1">2 Compuertas (r, u)</div>
  <div class="text-[11px] text-slate-500">1 Estado (h)</div>
  <div class="text-xs font-bold text-emerald-700 dark:text-emerald-300 mt-2">3 × d² Parámetros (25% menos)</div>
  </div>
  </div>
  <div class="text-[11px] text-slate-500 leading-snug">
    GRU converge significativamente más rápido en conjuntos de datos medianos o con recursos limitados.
  </div>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# Redes Recurrentes Bidireccionales

</v-click>

<div class="text-[13px] leading-snug space-y-1.5 pr-2">

<v-click>

### Pasado, Presente y Futuro simultáneos

</v-click>

<v-clicks>

- **Limitación unidireccional:** Una RNN tradicional en el paso $t$ solo conoce información anterior ($x_1, \dots, x_t$).
- **Solución Bidireccional (BiRNN / BiLSTM):**
  - Capa hacia adelante ($\overrightarrow{h}_t$): Lee la secuencia de izquierda a derecha.
  - Capa hacia atrás ($\overleftarrow{h}_t$): Lee la secuencia de derecha a izquierda.
- **Salida combinada:**
  $$\hat{y}_t = g\left( W_y [\overrightarrow{h}_t, \overleftarrow{h}_t] + b_y \right)$$
- **Requisito fundamental:** Toda la secuencia debe estar disponible con antelación *(no aplicable a predicción financiera en tiempo real)*.

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2">
  <BiRnnPlot />
</div>

</v-clicks>

---

<v-click>

# ¿Siguen siendo relevantes las LSTM frente a Transformers?

</v-click>

<div class="grid grid-cols-3 gap-5 mt-6 select-none">
  <div class="p-5 rounded-2xl bg-white/70 dark:bg-zinc-900/70 border border-slate-200 dark:border-zinc-800 shadow-xl flex flex-col justify-between">
  <div>
  <div class="text-rose-500 font-bold text-lg mb-2 flex items-center gap-1.5">
  <span>📉</span> Desafíos de LSTM
  </div>
  <ul class="text-xs text-slate-600 dark:text-zinc-300 space-y-2 list-disc pl-4">
  <li><strong>Naturaleza estrictamente secuencial:</strong> No se pueden paralelizar en GPU durante el entrenamiento.</li>
  <li><strong>Degradación en secuencias extensas:</strong> En secuencias de más de 500 pasos, el cuello de botella vectorial olvida detalles finos.</li>
  </ul>
  </div>
  <div class="text-[11px] font-mono text-slate-400 mt-3 pt-2 border-t border-slate-200 dark:border-zinc-800">
      Complejidad temporal: O(T)
  </div>
  </div>
  <div class="p-5 rounded-2xl bg-white/70 dark:bg-zinc-900/70 border border-slate-200 dark:border-zinc-800 shadow-xl flex flex-col justify-between">
  <div>
  <div class="text-emerald-500 font-bold text-lg mb-2 flex items-center gap-1.5">
  <span>⭐</span> ¿Dónde siguen ganando?
  </div>
  <ul class="text-xs text-slate-600 dark:text-zinc-300 space-y-2 list-disc pl-4">
  <li><strong>Dispositivos embebidos y Edge AI:</strong> Consumen una fracción insignificante de memoria RAM frente a un Transformer.</li>
  <li><strong>Inferencia paso a paso en tiempo real:</strong> Streaming de audio o sensores industriales de bajo costo.</li>
  <li><strong>Bajo volumen de datos:</strong> No requieren millones de parámetros pre-entrenados para converger.</li>
  </ul>
  </div>
  <div class="text-[11px] font-mono text-emerald-600 dark:text-emerald-400 mt-3 pt-2 border-t border-slate-200 dark:border-zinc-800">
      Huella de memoria: Mínima
  </div>
  </div>
  <div class="p-5 rounded-2xl bg-gradient-to-br from-indigo-500/10 to-purple-500/10 border border-indigo-200 dark:border-indigo-900/60 shadow-xl flex flex-col justify-between">
  <div>
  <div class="text-indigo-600 dark:text-indigo-400 font-bold text-lg mb-2 flex items-center gap-1.5">
  <span>🚀</span> La Era Transformer
  </div>
  <p class="text-xs text-slate-600 dark:text-zinc-300 leading-relaxed">
        El mecanismo de <strong>Atención (Self-Attention)</strong> permite conectar cualquier par de palabras directamente en <span class="font-mono text-indigo-500 font-bold">O(1)</span> operaciones sin depender de un estado recurrente.
  </p>
  </div>
  <div class="text-[11px] font-semibold text-indigo-700 dark:text-indigo-300 mt-3">
      Base de GPT, Llama y BERT
  </div>
  </div>
</div>

---
class: text-center
---

<v-click>

# 🛠️ Laboratorio Práctico de la Sesión 2

</v-click>

### De la teoría a la práctica en Python con TensorFlow / Keras

<div class="max-w-xl mx-auto mt-8 p-6 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-2xl text-left text-sm space-y-4">
  <div class="flex items-center gap-3">
  <div class="w-10 h-10 rounded-xl bg-indigo-100 dark:bg-indigo-950 flex items-center justify-center text-indigo-600 text-xl font-bold">1</div>
  <div>
  <div class="font-bold">Modelado de Series Temporales con LSTM</div>
  <div class="text-xs text-slate-500">Manejo del tensor tridimensional [samples, time_steps, features]</div>
  </div>
  </div>
  <div class="flex items-center gap-3">
  <div class="w-10 h-10 rounded-xl bg-amber-100 dark:bg-amber-950 flex items-center justify-center text-amber-600 text-xl font-bold">2</div>
  <div>
  <div class="font-bold">Benchmarking: Simple RNN vs. LSTM vs. GRU</div>
  <div class="text-xs text-slate-500">Comparación de velocidad de convergencia, loss y número de parámetros</div>
  </div>
  </div>
  <div class="flex items-center gap-3">
  <div class="w-10 h-10 rounded-xl bg-emerald-100 dark:bg-emerald-950 flex items-center justify-center text-emerald-600 text-xl font-bold">3</div>
  <div>
  <div class="font-bold">Inferencia Recurrente y Proyecciones Futuras</div>
  <div class="text-xs text-slate-500">Evaluación de estabilidad y retención de memoria a largo plazo</div>
  </div>
  </div>
</div>
