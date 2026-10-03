---
id: sesion3
routeAlias: sesion3
title: Sesión 3 - Diagnóstico, Regularización y Espectrogramas
info: |
  ## Sesión 3: Diagnóstico, Regularización y Espectrogramas
  DEEP LEARNING
  Pontificia Universidad Javeriana Cali — Pregrado
  Semestre 2026-2 · Tutor: Jan Polanco Velasco
---

<v-click>

# <span class="bg-gradient-to-r from-teal-400 via-cyan-400 to-indigo-500 bg-clip-text text-transparent font-extrabold">Diagnóstico, Regularización y Espectrogramas</span>

</v-click>

<v-click>

### De la señal unidimensional al procesamiento convolucional 2D

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

### Cuatro actos que conectan el entrenamiento con la visión convolucional

</v-click>

<div class="grid grid-cols-2 gap-4 mt-6">
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-indigo-500">01</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Diagnóstico Clínico</div>
<div class="text-xs text-slate-500 mt-1">Curvas de pérdida, overfitting, underfitting y patologías del gradiente.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-teal-500">02</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Estabilización y Regularización</div>
<div class="text-xs text-slate-500 mt-1">Early Stopping, Dropout y Gradient Clipping.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-cyan-500">03</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">De Señales 1D a Imágenes 2D</div>
<div class="text-xs text-slate-500 mt-1">Audio crudo, STFT y espectrogramas como imágenes.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-purple-500">04</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Convolución y Pooling</div>
<div class="text-xs text-slate-500 mt-1">Downscaling, invarianza y Max vs. Average Pooling.</div>
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

# Diagnóstico Clínico del Entrenamiento

</v-click>

<v-click>

### Curvas de pérdida, overfitting, underfitting y patologías del gradiente

</v-click>

---
layout: two-cols
---

<v-click>

# Diagnóstico de Modelos

</v-click>

<v-click>

### Interpretando las Curvas de Aprendizaje

</v-click>

<v-clicks>

- **La ventana a la mente de la red:** las curvas de pérdida (*Loss vs. Epochs*) son la herramienta clínica fundamental para diagnosticar el entrenamiento.
- **Generalization Gap:** la brecha entre la pérdida de entrenamiento ($\mathcal{L}_{\text{train}}$) y la de validación ($\mathcal{L}_{\text{val}}$).
- **Sobreajuste (*Overfitting*):** $\mathcal{L}_{\text{train}} \to 0$ mientras $\mathcal{L}_{\text{val}}$ repunta; la red memoriza el ruido.
- **Subajuste (*Underfitting*):** ambas curvas se estancan en valores altos; falta de capacidad o hipótesis muy rígida.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2">
<TrainingCurvesDiagnostics />
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# Patologías del Gradiente

</v-click>

<v-click>

### Desvanecimiento vs. Explosión

</v-click>

<v-clicks>

- **Gradientes que se desvanecen (*Vanishing*):** a través de capas profundas $\|\nabla W\| \to 0$. Las primeras capas dejan de aprender y se *congelan*.
- **Gradientes que explotan (*Exploding*):** $\|\nabla W\| \to \infty$, provocando oscilaciones violentas o valores `NaN`.
- **Causa raíz:** el producto encadenado de Jacobianos al retropropagar por muchas capas.

</v-clicks>

<v-clicks>

**Gradient Clipping (recorte por norma):**

$$g \leftarrow \begin{cases} g & \text{si } \|g\| \le c \\ c \cdot \dfrac{g}{\|g\|} & \text{si } \|g\| > c \end{cases}$$

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-2 text-xs w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100 flex items-center gap-2"><span>🛡️</span> Gradient Clipping en Keras</div>
<div class="p-2.5 rounded-xl bg-slate-900 text-indigo-300 font-mono text-[11px] leading-relaxed">
optimizer = tf.keras.optimizers.Adam(<br>
&nbsp;&nbsp;learning_rate=0.001,<br>
&nbsp;&nbsp;<span class="text-amber-400 font-bold">clipnorm=1.0</span><br>
)
</div>
<p class="text-slate-600 dark:text-zinc-300 text-[11px] leading-snug">Si la norma del gradiente supera el umbral <strong>c</strong>, se reescala conservando su dirección. Evita que un lote corrupto destruya los pesos de la red.</p>
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

# Arsenal de Estabilización y Regularización

</v-click>

<v-click>

### Early Stopping, Dropout y Gradient Clipping

</v-click>

---
layout: two-cols
---

<v-click>

# Early Stopping (Detención Temprana)

</v-click>

<v-click>

### Detener a tiempo es una forma de regularizar

</v-click>

<v-clicks>

- Monitorea una métrica de validación (típicamente `val_loss`) tras cada época.
- Si no mejora durante un número de épocas de gracia (*patience*), detiene el entrenamiento.
- Con `restore_best_weights=True` recupera los pesos de la **mejor época**, no los últimos.
- **No es solo diagnóstico:** es una técnica de regularización que evita que el modelo entre en la zona de sobreajuste.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-2 text-xs w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100">Callback en Keras</div>
<div class="p-2.5 rounded-xl bg-slate-900 text-amber-300 font-mono text-[11px] leading-relaxed">
es = tf.keras.callbacks.EarlyStopping(<br>
&nbsp;&nbsp;monitor=<span class="text-emerald-400">'val_loss'</span>,<br>
&nbsp;&nbsp;<span class="text-amber-400 font-bold">patience=8</span>,<br>
&nbsp;&nbsp;restore_best_weights=<span class="text-indigo-300">True</span><br>
)<br>
<br>
model.fit(..., callbacks=[es])
</div>
<p class="text-slate-600 dark:text-zinc-300 text-[11px] leading-snug">La <em>paciencia</em> deja margen a que la pérdida vuelva a bajar antes de rendirse.</p>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# Dropout

</v-click>

<v-click>

### Apagar neuronas para forzar representaciones robustas

</v-click>

<v-clicks>

- En cada paso de entrenamiento, cada neurona se "apaga" con probabilidad $p$ (p. ej. $p = 0.3$).
- **Efecto:** rompe co-adaptaciones; la red no puede depender de una sola neurona.
- **Dropout invertido:** en inferencia no se apaga nada; las activaciones se escalan por $(1-p)$ durante el entrenamiento para mantener la misma esperanza.
- Equivale a entrenar un **ensamble implícito** de $2^N$ sub-redes que comparten pesos.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl text-xs w-full select-none text-center">
<div class="font-bold text-slate-700 dark:text-zinc-200 mb-1">Dropout (p = 0.3) — apagado aleatorio</div>
<svg viewBox="0 0 300 190" class="w-full h-[150px]">
<defs>
<marker id="do-arr" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
<path d="M 0 2 L 7 5 L 0 8 z" class="fill-slate-500 dark:fill-zinc-400" />
</marker>
</defs>
<g class="stroke-slate-400 dark:stroke-zinc-600" stroke-width="1" opacity="0.5">
<line x1="52" y1="42" x2="140" y2="26" />
<line x1="52" y1="42" x2="140" y2="60" />
<line x1="52" y1="42" x2="140" y2="94" />
<line x1="52" y1="42" x2="140" y2="128" />
<line x1="52" y1="42" x2="140" y2="162" />
<line x1="52" y1="80" x2="140" y2="26" />
<line x1="52" y1="80" x2="140" y2="60" />
<line x1="52" y1="80" x2="140" y2="94" />
<line x1="52" y1="80" x2="140" y2="128" />
<line x1="52" y1="80" x2="140" y2="162" />
<line x1="52" y1="118" x2="140" y2="26" />
<line x1="52" y1="118" x2="140" y2="60" />
<line x1="52" y1="118" x2="140" y2="94" />
<line x1="52" y1="118" x2="140" y2="128" />
<line x1="52" y1="118" x2="140" y2="162" />
<line x1="52" y1="156" x2="140" y2="26" />
<line x1="52" y1="156" x2="140" y2="60" />
<line x1="52" y1="156" x2="140" y2="94" />
<line x1="52" y1="156" x2="140" y2="128" />
<line x1="52" y1="156" x2="140" y2="162" />
<line x1="162" y1="26" x2="250" y2="78" />
<line x1="162" y1="60" x2="250" y2="78" />
<line x1="162" y1="94" x2="250" y2="78" />
<line x1="162" y1="128" x2="250" y2="78" />
<line x1="162" y1="162" x2="250" y2="78" />
<line x1="162" y1="26" x2="250" y2="118" />
<line x1="162" y1="60" x2="250" y2="118" />
<line x1="162" y1="94" x2="250" y2="118" />
<line x1="162" y1="128" x2="250" y2="118" />
<line x1="162" y1="162" x2="250" y2="118" />
</g>
<circle cx="40" cy="42" r="10" class="fill-blue-100 stroke-blue-600 dark:fill-blue-950/60" stroke-width="1.8" />
<circle cx="40" cy="80" r="10" class="fill-blue-100 stroke-blue-600 dark:fill-blue-950/60" stroke-width="1.8" />
<circle cx="40" cy="118" r="10" class="fill-blue-100 stroke-blue-600 dark:fill-blue-950/60" stroke-width="1.8" />
<circle cx="40" cy="156" r="10" class="fill-blue-100 stroke-blue-600 dark:fill-blue-950/60" stroke-width="1.8" />
<circle cx="150" cy="26" r="11" class="fill-emerald-100 stroke-emerald-600 dark:fill-emerald-950/60" stroke-width="1.8" />
<circle cx="150" cy="60" r="11" class="fill-rose-100 stroke-rose-600 dark:fill-rose-950/60" stroke-width="1.8" />
<circle cx="150" cy="94" r="11" class="fill-emerald-100 stroke-emerald-600 dark:fill-emerald-950/60" stroke-width="1.8" />
<circle cx="150" cy="128" r="11" class="fill-rose-100 stroke-rose-600 dark:fill-rose-950/60" stroke-width="1.8" />
<circle cx="150" cy="162" r="11" class="fill-emerald-100 stroke-emerald-600 dark:fill-emerald-950/60" stroke-width="1.8" />
<line x1="142" y1="52" x2="158" y2="68" class="stroke-rose-600" stroke-width="2.5" />
<line x1="158" y1="52" x2="142" y2="68" class="stroke-rose-600" stroke-width="2.5" />
<line x1="142" y1="120" x2="158" y2="136" class="stroke-rose-600" stroke-width="2.5" />
<line x1="158" y1="120" x2="142" y2="136" class="stroke-rose-600" stroke-width="2.5" />
<rect x="240" y="68" width="34" height="60" rx="8" class="fill-rose-100 stroke-rose-600 dark:fill-rose-950/60" stroke-width="1.8" />
<text x="257" y="103" text-anchor="middle" class="text-[10px] font-serif italic font-bold fill-rose-900 dark:fill-rose-200">ŷ</text>
</svg>
<div class="text-[11px] text-slate-500">Las neuronas en rojo se desactivan en esta iteración.</div>
</div>
</div>

</v-clicks>

---
layout: default
---

<v-click>

# El Botiquín Completo de Regularización

</v-click>

<div class="grid grid-cols-2 gap-4 mt-5">
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-indigo-600 dark:text-indigo-400">Batch Normalization</div>
<div class="text-xs text-slate-600 dark:text-zinc-300 mt-1">Normaliza las activaciones por lote. Acelera la convergencia y reduce la sensibilidad a la inicialización.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-emerald-600 dark:text-emerald-400">Weight Decay (L2)</div>
<div class="text-xs text-slate-600 dark:text-zinc-300 mt-1">Penaliza pesos grandes con penalización L2 sobre los pesos (λ · Σw²). Mantiene la función suave y evita el sobreajuste.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-amber-600 dark:text-amber-400">Data Augmentation</div>
<div class="text-xs text-slate-600 dark:text-zinc-300 mt-1">Genera variaciones realistas (ruido, desplazamientos temporales) para ampliar el conjunto de entrenamiento.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-purple-600 dark:text-purple-400">Inicialización Adecuada</div>
<div class="text-xs text-slate-600 dark:text-zinc-300 mt-1">He/Glorot mantienen la varianza del gradiente estable entre capas, combatiendo el desvanecimiento.</div>
</div>
</div>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-cyan-500/25">03</div>

</v-click>

<v-click>

# De Señales 1D a Imágenes 2D

</v-click>

<v-click>

### Audio crudo, STFT y espectrogramas

</v-click>

---
layout: two-cols
---

<v-click>

# Procesamiento de Audio: la Señal 1D

</v-click>

<v-click>

### ¿Por qué el audio crudo es difícil para una red?

</v-click>

<v-clicks>

- **Forma de onda (*Waveform*):** la presión sonora registrada en el tiempo $x(t)$.
- **Frecuencia de muestreo:** a 16 kHz (estándar de voz), 1 segundo contiene **16.000 muestras** numéricas.
- **Desafíos:**
  - Dimensionalidad colosal para una red densa o recurrente.
  - La forma de onda es extremadamente sensible al desfase de fase.
- **Solución clásica:** pasar del dominio del tiempo al **dominio de la frecuencia**.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl w-full select-none text-center">
<div class="font-bold text-slate-700 dark:text-zinc-200 font-mono text-xs">Onda Sonora: Dominio del Tiempo x(t)</div>
<svg viewBox="0 0 300 120" class="w-full h-[130px]">
<line x1="10" y1="60" x2="290" y2="60" stroke="#94a3b8" stroke-dasharray="3 3" />
<path d="M 10 60 Q 30 10 50 60 T 90 60 T 130 60 T 170 60 T 210 60 T 250 60 T 290 60" fill="none" stroke="#2563eb" stroke-width="2" />
<path d="M 10 60 Q 20 30 30 60 T 50 60 T 70 60 T 90 60 T 110 60 T 130 60 T 150 60 T 170 60 T 190 60 T 210 60 T 230 60 T 250 60 T 270 60 T 290 60" fill="none" stroke="#60a5fa" stroke-width="1" opacity="0.7" />
</svg>
<div class="text-[11px] text-slate-500">1 segundo = 16.000 valores de amplitud.</div>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# De la Señal al Espectrograma

</v-click>

<v-click>

### STFT: Short-Time Fourier Transform

</v-click>

<v-clicks>

- **El principio:** una Transformada de Fourier global pierde el tiempo. Necesitamos saber *qué frecuencias ocurren y en qué momento*.
- **Ventana deslizante:** dividimos la señal en fragmentos (`frame_length=255`) y avanzamos con solapamiento (`frame_step=128`).
- A cada ventana se le aplica la FFT:
  $$X(t, f) = \sum_{n=-\infty}^{\infty} x[n] \cdot w[n - t] \cdot e^{-j 2\pi f n}$$
- **Resultado:** una matriz 2D **Tiempo × Frecuencia** que se procesa como una imagen.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2">
<SpectrogramHeatmap />
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

# Introducción a la Convolución y Pooling

</v-click>

<v-click>

### La necesidad de downscaling e invarianza

</v-click>

---
layout: two-cols
---

<v-click>

# El Gran Salto: Visión Convolucional en Audio

</v-click>

<div class="text-[12px] leading-snug space-y-1 pr-2">

<v-click>

### ¿Por qué aplicar convolución 2D a un espectrograma?

</v-click>

<v-clicks>

- **El audio se convirtió en una imagen:** tensor `(124, 129, 1)` *(Tiempo, Frecuencia, Canal)*.
- **Patrones locales:** los fonemas tienen firmas espectrales (formantes, silencios, transitorios).
- **Invarianza temporal:** una palabra 100 ms después conserva su forma, solo se desplaza en el eje temporal.
- Las capas **`Conv2D`** extraen esos patrones con **filtros compartidos** (muchos menos parámetros que una red densa).

</v-clicks>

</div>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100 font-mono text-[11px] mb-1">Pipeline del Laboratorio: Audio ➔ CNN</div>
<div class="space-y-1.5 text-[11px]">
<div class="p-2 rounded-lg bg-blue-50 dark:bg-blue-950/40 border border-blue-200 dark:border-blue-900 font-mono">1. Audio .WAV (16.000 muestras)</div>
<div class="p-2 rounded-lg bg-teal-50 dark:bg-teal-950/40 border border-teal-200 dark:border-teal-900 font-mono">2. STFT ➔ Tensor (124, 129, 1)</div>
<div class="p-2 rounded-lg bg-indigo-50 dark:bg-indigo-950/40 border border-indigo-200 dark:border-indigo-900 font-mono">3. Conv2D + MaxPooling2D</div>
<div class="p-2 rounded-lg bg-purple-50 dark:bg-purple-950/40 border border-purple-200 dark:border-purple-900 font-mono">4. GlobalAveragePooling2D</div>
<div class="p-2 rounded-lg bg-rose-50 dark:bg-rose-950/40 border border-rose-200 dark:border-rose-900 font-mono">5. Dropout ➔ Dense(3, Softmax)</div>
</div>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# Capas de Pooling (Submuestreo)

</v-click>

<v-click>

### Reducción dimensional e invarianzas espaciales

</v-click>

<v-clicks>

- **Objetivo central:** reducir las dimensiones espaciales preservando la información semántica relevante.
- **Fórmula de dimensionalidad de salida:**
  $$O = \left\lfloor \frac{N - f}{s} \right\rfloor + 1$$
  - $N$: tamaño de entrada · $f$: tamaño del filtro · $s$: salto (*stride*).
- **Beneficios clave:**
  1. Reduce el cómputo y la cantidad de parámetros.
  2. Aporta **invarianza a traslaciones** y pequeñas perturbaciones.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2">
<PoolingSimulator />
</div>

</v-clicks>

---

<v-click>

# Max Pooling vs. Average Pooling

</v-click>

<div class="grid grid-cols-2 gap-6 mt-6 select-none">
<div v-click class="p-5 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl flex flex-col justify-between">
<div>
<div class="text-indigo-600 dark:text-indigo-400 font-bold text-lg mb-2 flex items-center gap-2"><span>⚡</span> Max Pooling</div>
<ul class="text-xs text-slate-600 dark:text-zinc-300 space-y-2.5 list-disc pl-4">
<li><strong>Operación:</strong> toma el valor máximo dentro de cada ventana: max(R).</li>
<li><strong>Semántica:</strong> "¿apareció la característica buscada en esta región?" (un borde, un formante).</li>
<li><strong>Uso:</strong> entre bloques de convolución intermedios para resaltar patrones fuertes.</li>
</ul>
</div>
<div class="p-2 mt-3 rounded-lg bg-indigo-50 dark:bg-indigo-950/40 text-[11px] font-mono text-indigo-700 dark:text-indigo-300">Prioriza las activaciones dominantes sobre el fondo.</div>
</div>
<div v-click class="p-5 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl flex flex-col justify-between">
<div>
<div class="text-emerald-600 dark:text-emerald-400 font-bold text-lg mb-2 flex items-center gap-2"><span>🌊</span> Average Pooling</div>
<ul class="text-xs text-slate-600 dark:text-zinc-300 space-y-2.5 list-disc pl-4">
<li><strong>Operación:</strong> promedio aritmético de la región: (1 / |R|) · Σ xᵢ.</li>
<li><strong>Semántica:</strong> mide la presencia media o el contexto general del mapa.</li>
<li><strong>Uso:</strong> muy común como <em>Global Average Pooling</em> antes de la capa final.</li>
</ul>
</div>
<div class="p-2 mt-3 rounded-lg bg-emerald-50 dark:bg-emerald-950/40 text-[11px] font-mono text-emerald-700 dark:text-emerald-300">Suaviza la señal y retiene información de contexto global.</div>
</div>
</div>

---

<v-click>

# Arquitectura Convolucional del Laboratorio

</v-click>

````md magic-move
```python
# Paso 1: Carga y extracción del espectrograma (STFT)
wav = load_wav_16k_mono("audio.wav")[:16000]
spectrogram = tf.signal.stft(wav, frame_length=255, frame_step=128)
spectrogram = tf.abs(spectrogram)          # Forma: (124, 129)
X = tf.expand_dims(spectrogram, axis=-1)   # (124, 129, 1)
```
```python
# Paso 2: Bloques convolucionales con downscaling progresivo
model = Sequential([
    Input(shape=(124, 129, 1)),
    Conv2D(16, 3, activation="relu", padding="same"),
    MaxPooling2D(pool_size=2),                             # 62 x 64
    Conv2D(32, 3, activation="relu", padding="same"),
    MaxPooling2D(pool_size=2),                             # 31 x 32
    Conv2D(64, 3, activation="relu", padding="same"),
    GlobalAveragePooling2D(),                              # 64 características
    Dropout(0.3),
    Dense(3, activation="softmax")                         # 3 clases
])
```
```python
# Paso 3: Regularización, compilación y callbacks
model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001, clipnorm=1.0),
    loss="categorical_crossentropy",
    metrics=["accuracy"]
)

early = tf.keras.callbacks.EarlyStopping(
    monitor="val_loss", patience=8, restore_best_weights=True
)

history = model.fit(
    X_train, Y_train,
    validation_data=(X_val, Y_val),
    epochs=50, batch_size=16, callbacks=[early]
)
```
````

---
class: text-center
---

<v-click>

# 🛠️ Laboratorio Práctico de la Sesión 3

</v-click>

<v-click>

### Clasificación Acústica Multiclase con Espectrogramas y CNN

</v-click>

<div class="max-w-xl mx-auto mt-6 p-6 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-2xl text-left text-sm space-y-4">
<div v-click class="flex items-center gap-3">
<div class="w-10 h-10 rounded-xl bg-blue-100 dark:bg-blue-950 flex items-center justify-center text-blue-600 text-xl font-bold">1</div>
<div>
<div class="font-bold">Pipeline STFT y visualización 2D/3D</div>
<div class="text-xs text-slate-500">Conversión de archivos .WAV a tensores espectrales en decibelios.</div>
</div>
</div>
<div v-click class="flex items-center gap-3">
<div class="w-10 h-10 rounded-xl bg-indigo-100 dark:bg-indigo-950 flex items-center justify-center text-indigo-600 text-xl font-bold">2</div>
<div>
<div class="font-bold">Entrenamiento de la CNN (Conv2D + Pooling)</div>
<div class="text-xs text-slate-500">Extracción jerárquica de características acústicas invariantes.</div>
</div>
</div>
<div v-click class="flex items-center gap-3">
<div class="w-10 h-10 rounded-xl bg-emerald-100 dark:bg-emerald-950 flex items-center justify-center text-emerald-600 text-xl font-bold">3</div>
<div>
<div class="font-bold">Evaluación clínica: matriz de confusión y F1-Score</div>
<div class="text-xs text-slate-500">Diagnóstico de aciertos, falsos positivos y balance por clase.</div>
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
<div class="font-bold text-indigo-600 dark:text-indigo-400 text-sm">Diagnóstico</div>
<div class="text-xs text-slate-500 mt-1">Leer las curvas de pérdida y reconocer overfitting, underfitting y patologías del gradiente.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-teal-600 dark:text-teal-400 text-sm">Regularización</div>
<div class="text-xs text-slate-500 mt-1">Dropout, Early Stopping y Gradient Clipping como herramientas de estabilización.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-cyan-600 dark:text-cyan-400 text-sm">Señales</div>
<div class="text-xs text-slate-500 mt-1">La STFT convierte una señal 1D en un espectrograma 2D: tiempo × frecuencia.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-purple-600 dark:text-purple-400 text-sm">Convolución</div>
<div class="text-xs text-slate-500 mt-1">Conv2D y Pooling explotan la estructura espacial con invarianza a traslaciones.</div>
</div>
</div>

<v-click>

<div class="mt-8 opacity-70">
  DEEP LEARNING · Pontificia Universidad Javeriana Cali<br>
  <strong>Jan Polanco Velasco</strong>
</div>

</v-click>
