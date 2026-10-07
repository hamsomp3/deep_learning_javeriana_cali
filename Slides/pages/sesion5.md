---
id: sesion5
routeAlias: sesion5
title: Sesión 5 - Competencia Kaggle - Pronóstico de una Serie Temporal Anónima
info: |
  ## Sesión 5: Competencia Kaggle — Pronóstico de una Serie Temporal Anónima
  DEEP LEARNING
  Pontificia Universidad Javeriana Cali — Pregrado
  Semestre 2026-2 · Tutor: Jan Polanco Velasco
---

<v-click>

# <span class="bg-gradient-to-r from-amber-400 via-orange-500 to-rose-500 bg-clip-text text-transparent font-extrabold">🏆 Competencia Final</span>

</v-click>

<v-click>

### Pronóstico de una serie temporal anónima a 24 pasos

</v-click>

<v-click>

**Jan Polanco Velasco** · Deep Learning — Pontificia Universidad Javeriana Cali

</v-click>

---
layout: default
---

<v-click>

# Hoja de Ruta de la Competencia

</v-click>

<v-click>

### Del modelo que entrenaste al *leaderboard* de cierre

</v-click>

<div class="grid grid-cols-2 gap-4 mt-6">
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-amber-500">01</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">La Misión</div>
<div class="text-xs text-slate-500 mt-1">Qué predices, qué te damos y por qué la serie es anónima.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-rose-500">02</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Reglas y Evaluación</div>
<div class="text-xs text-slate-500 mt-1">Métrica RMSE, desempate MAE y el listón a superar.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-indigo-500">03</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Tu Entrega</div>
<div class="text-xs text-slate-500 mt-1">Formato exacto del CSV y validaciones automáticas.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="text-2xl font-black text-emerald-500">04</div>
<div class="font-bold text-slate-800 dark:text-zinc-100">Estrategia Ganadora</div>
<div class="text-xs text-slate-500 mt-1">Ruta sugerida, ideas para mejorar y errores frecuentes.</div>
</div>
</div>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-amber-500/25">01</div>

</v-click>

<v-click>

# La Misión

</v-click>

<v-click>

### Predecir el futuro de una serie que nunca has visto

</v-click>

---
layout: two-cols
---

<v-click>

# ¿Qué es una Competencia Kaggle?

</v-click>

<v-click>

### El formato estándar de las competencias de Machine Learning

</v-click>

<v-clicks>

- **Una plataforma, un reto:** Kaggle propone un problema con un dataset y un *leaderboard*.
- **Envías predicciones**, no código ejecutado: un archivo con tu respuesta.
- **El *leaderboard* es ciego:** no ves la solución, solo tu puntaje.
- **Se compite contra el mundo** (o contra tu salón), con reglas y plazos claros.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-3 text-xs w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100 flex items-center gap-1.5">
<span>🔍</span> Cómo lo haremos aquí
</div>
<div class="p-2.5 rounded-xl bg-slate-100 dark:bg-zinc-800 font-mono text-[10px] text-slate-600 dark:text-zinc-300 leading-relaxed border border-slate-200 dark:border-zinc-700">
Entrenas tu red localmente<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↓<br>
Entregas <b>submission.csv</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↓<br>
El evaluador la puntúa<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↓<br>
<b>Leaderboard + certificado</b>
</div>
<p class="text-[11px] text-slate-600 dark:text-zinc-300 leading-snug">
Nosotros guardamos los <strong>24 valores reales</strong> del futuro. Tú nunca los ves: es una competencia <strong>ciega</strong>.
</p>
</div>
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>

# La Misión

</v-click>

<v-click>

### Un problema de pronóstico, en su forma más pura

</v-click>

<v-clicks>

- Se te entrega **una serie histórica anónima**, univariada y con estructura periódica.
- Debes predecir los **24 valores siguientes** con una **red neuronal**.
- Solo ves el **pasado**; el futuro lo reserva el docente.
- Cierra el seminario: aquí aplicas **preprocesamiento, arquitecturas recurrentes, regularización y evaluación**.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-3 text-xs w-full select-none text-center">
<div class="font-bold text-slate-800 dark:text-zinc-100 text-xs">Pasado visible vs. futuro oculto</div>
<div class="flex items-center justify-center gap-2 py-2 text-[10px] font-mono">
<div class="p-3 rounded-lg bg-emerald-50 dark:bg-emerald-950/60 border border-emerald-200 dark:border-emerald-800 flex-1">
<div class="font-bold text-emerald-600">✓ Tú lo ves</div>
<div class="text-slate-500 mt-1">t = 0 … 2819</div>
<div class="text-slate-500">2.820 valores</div>
</div>
<span class="font-bold text-slate-400">+</span>
<div class="p-3 rounded-lg bg-rose-50 dark:bg-rose-950/60 border border-rose-200 dark:border-rose-800 flex-1">
<div class="font-bold text-rose-600">🔒 Oculto</div>
<div class="text-slate-500 mt-1">t = 2820 … 2843</div>
<div class="text-slate-500">24 valores</div>
</div>
</div>
<div class="p-2 rounded-lg bg-amber-50 dark:bg-amber-950/40 text-[11px] text-amber-900 dark:text-amber-200 leading-tight">
Tu modelo aprende del pasado y <strong>extrapola</strong> 24 pasos hacia adelante.
</div>
</div>
</div>

</v-clicks>

---
layout: default
---

<v-click>

# La Serie Anónima

</v-click>

<v-click>

### Un archivo, dos columnas: `t` y `valor`

</v-click>

El archivo `serie_anonima.csv` trae **2.820 observaciones** consecutivas y sin faltantes. Últimos pasos:

| t | valor |
|---|---|
| 2817 | −0.156138 |
| 2818 | −0.549874 |
| **2819** | **−0.551343** |

<v-click>

> ⚠️ Los valores están **estandarizados**: no tienen unidades reconocibles. El índice `t` es un simple entero, **no** una fecha. La fuente del fenómeno permanece **oculta a propósito**.

</v-click>

---
layout: default
---

<v-click>

# 🕵️ Código de Honor

</v-click>

<v-click>

### Una competencia formativa, no un examen de memoria

</v-click>

<v-clicks>

- **No intentes identificar el origen** de la serie ni su fenómeno.
- **No busques los valores futuros** por internet ni los inyectes en el entrenamiento.
- El valor está en **diseñar, regularizar y comparar arquitecturas**, no en copiar un resultado.
- Un puntaje “perfecto” obtenido con ayuda externa **no cuenta** (y es fácil de auditar).

</v-clicks>

<v-click>

> 💡 La serie está anonimizada a propósito. **Respeta el acuerdo**: compite con modelado, no con atajos sobre la fuente.

</v-click>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-rose-500/25">02</div>

</v-click>

<v-click>

# Reglas y Evaluación

</v-click>

<v-click>

### Cómo se decide quién gana (y quién certifica)

</v-click>

---
layout: default
---

<v-click>

# Las Reglas son Simples

</v-click>

<v-clicks>

1. Predice los **24 pasos siguientes** de la serie con una **red neuronal**.
2. Métrica principal: **RMSE** (menor = mejor). Desempate: **MAE**.
3. Entrega un CSV con **24 filas** y columnas exactas `t,Predicted`.
4. **Certificas** si tu RMSE es **menor que el de la persistencia** (repetir el último valor observado).

</v-clicks>

<v-click>

> 🎯 No se trata de “acertar por suerte”, sino de demostrar que tu red **aporta valor** frente a no modelar nada.

</v-click>

---
layout: two-cols
---

<v-click>

# La Métrica: RMSE

</v-click>

<v-click>

### Castigando los errores grandes

</v-click>

El **RMSE** promedia el error cuadrático y le aplica raíz:

$$\text{RMSE} = \sqrt{\frac{1}{n}\sum_{i=1}^{n}\left(y_i - \hat{y}_i\right)^2}$$

<v-clicks>

- $y_i$: valor real (oculto para ti).
- $\hat{y}_i$: tu predicción.
- $n = 24$ pasos.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl space-y-3 text-xs w-full select-none">
<div class="font-bold text-slate-800 dark:text-zinc-100 text-xs">¿Por qué RMSE y no solo MAE?</div>
<div class="p-2.5 rounded-xl bg-slate-100 dark:bg-zinc-800 font-mono text-[10px] text-slate-600 dark:text-zinc-300 border border-slate-200 dark:border-zinc-700">
MAE = (1 / n) · Σ |yᵢ − ŷᵢ|
</div>
<ul class="text-[11px] text-slate-600 dark:text-zinc-300 space-y-2 list-disc pl-4">
<li>El RMSE <strong>penaliza más</strong> los errores grandes (eleva al cuadrado).</li>
<li>El MAE se usa como <strong>desempate</strong> cuando dos RMSE empatan.</li>
<li>Compárate siempre contra un baseline honesto.</li>
</ul>
</div>
</div>

</v-clicks>

---
layout: default
---

<v-click>

# El Listón: Batir a los Baselines

</v-click>

<v-click>

### ¿Qué tan bueno es “no modelar nada”?

</v-click>

| Baseline | Idea | Rol |
|---|---|---|
| **Persistencia** | Repetir el último valor observado (t = 2819) durante los 24 pasos | **El listón a superar** |
| Climatología | Repetir el promedio histórico de la serie | Referencia |
| *Seasonal naive* | Repetir el patrón del ciclo anterior | Referencia |

<v-click>

> 🏅 **Certificas** si tu RMSE es **menor** que el de la persistencia: tu red demuestra un *skill* real. En tu validación interna deberías reproducir esta comparación antes de entregar.

</v-click>

---
layout: default
---

<v-click>

# Certificado y Reconocimiento

</v-click>

<v-click>

### Un incentivo para cerrar el seminario con buen modelado

</v-click>

<v-clicks>

- 🥇 **Certificado de asistencia** al seminario: si superas la persistencia.
- 🏆 **Reconocimiento especial** al Top 3 del *leaderboard*.
- 📊 El **skill** mide cuánto mejoras respecto al baseline.

</v-clicks>

El *skill* se define como:

$$\text{skill} = 1 - \frac{\text{RMSE}}{\text{RMSE}_{\text{persistencia}}}$$

<v-click>

> Si `skill > 0`, tu modelo **aporta valor** y certifica. Si `skill ≤ 0`, empatas o pierdes contra no modelar nada.

</v-click>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-indigo-500/25">03</div>

</v-click>

<v-click>

# Tu Entrega

</v-click>

<v-click>

### Un CSV de 24 filas, sin ambigüedades

</v-click>

---
layout: two-cols
---

<v-click>

# Formato de la Entrega

</v-click>

<v-click>

### `submissions/<tu_nombre>.csv`

</v-click>

```csv
t,Predicted
2820,-0.300000
2821,-0.250000
...
2843,0.100000
```

<v-clicks>

- Exactamente **24 filas** (más el encabezado).
- Columnas exactas: **`t,Predicted`**.
- `t` va de **2820 a 2843**, sin huecos ni repetidos.
- Valores de ejemplo: los tuyos serán los de tu modelo.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-rose-50/80 dark:bg-rose-950/40 border border-rose-300 dark:border-rose-800 shadow-xl space-y-2 text-xs w-full select-none">
<div class="font-bold text-rose-900 dark:text-rose-200 flex items-center gap-1.5">
<span>❌</span> Se invalida si…
</div>
<div class="p-2.5 rounded-xl bg-white dark:bg-zinc-900 font-mono text-[10px] text-slate-600 dark:text-zinc-300 leading-relaxed border border-rose-200 dark:border-rose-900">
• 23 o 25 filas<br>
• columnas mal escritas (<i>predicted</i>, <i>T</i>…)<br>
• <b>t</b> desalineado o incompleto<br>
• archivo sin tu nombre
</div>
<p class="text-[11px] text-slate-600 dark:text-zinc-300 leading-snug">
Revisa este formato <strong>antes</strong> de entregar: es el error más común y el más fácil de evitar.
</p>
</div>
</div>

</v-clicks>

---
layout: default
---

<v-click>

# Del CSV al Leaderboard

</v-click>

<v-click>

### Qué pasa después de que entregas

</v-click>

<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl my-4 text-xs font-mono select-none">
<div class="flex items-center justify-between gap-2 text-center">
<div class="p-3 rounded-xl bg-amber-50 dark:bg-amber-950/40 border border-amber-200 dark:border-amber-800 flex-1">
<div class="font-bold text-amber-700 dark:text-amber-300 text-xs">Tu CSV</div>
<div class="text-[10px] text-slate-500 mt-1">24 predicciones</div>
<div class="text-[9px] text-amber-600 mt-2 font-sans">submissions/</div>
</div>
<span class="text-slate-400 font-bold">➔</span>
<div class="p-3 rounded-xl bg-indigo-50 dark:bg-indigo-950/40 border border-indigo-200 dark:border-indigo-800 flex-[1.4]">
<div class="font-bold text-indigo-700 dark:text-indigo-300 text-xs">Evaluador</div>
<div class="text-[10px] text-slate-500 mt-1">valida formato + compara</div>
<div class="text-[9px] text-indigo-600 mt-2 font-sans">contra el futuro oculto</div>
</div>
<span class="text-slate-400 font-bold">➔</span>
<div class="p-3 rounded-xl bg-teal-50 dark:bg-teal-950/40 border border-teal-200 dark:border-teal-800 flex-1">
<div class="font-bold text-teal-700 dark:text-teal-300 text-xs">RMSE / MAE</div>
<div class="text-[10px] text-slate-500 mt-1">más <i>skill</i></div>
<div class="text-[9px] text-teal-600 mt-2 font-sans">menor = mejor</div>
</div>
<span class="text-slate-400 font-bold">➔</span>
<div class="p-3 rounded-xl bg-rose-50 dark:bg-rose-950/40 border border-rose-200 dark:border-rose-800 flex-1">
<div class="font-bold text-rose-700 dark:text-rose-300 text-xs">Leaderboard</div>
<div class="text-[10px] text-slate-500 mt-1">ranking + certificados</div>
<div class="text-[9px] text-rose-600 mt-2 font-sans">Top 3 reconocido</div>
</div>
</div>
</div>

<v-click>

> 🔎 **Transparencia:** se audita el Top-N (notebook, semillas y arquitectura) para confirmar que el modelo **entrenó de verdad**.

</v-click>

---
layout: default
---

<v-click>

# Checklist Antes de Entregar

</v-click>

<v-clicks>

- ✅ El CSV tiene **exactamente 24 filas** (sin contar el encabezado).
- ✅ Las columnas se llaman **`t,Predicted`** (respeta mayúsculas).
- ✅ El índice `t` es exactamente **2820 … 2843**, sin huecos ni repetidos.
- ✅ El archivo se llama con **tu nombre**: `submissions/jan_perez.csv`.
- ✅ Corriste el notebook de principio a fin **sin errores** y guardaste tus semillas.

</v-clicks>

---
layout: default
class: text-center
---

<v-click>

<div class="text-[80px] font-black leading-none text-emerald-500/25">04</div>

</v-click>

<v-click>

# Estrategia Ganadora

</v-click>

<v-click>

### Ruta sugerida, ideas y errores que debes evitar

</v-click>

---
layout: default
---

<v-click>

# Ruta Sugerida

</v-click>

<v-click>

### Un plan de trabajo en seis pasos

</v-click>

<v-clicks>

1. **Explora** la serie: tendencia, periodicidad y escala.
2. **Preprocesa** a ventanas: tú decides `WINDOW_SIZE` (prueba 12, 24 o 48).
3. **Entrena** un modelo base y mide su RMSE en una **validación interna**.
4. **Pronostica** de forma **recursiva** los 24 pasos.
5. **Genera** y guarda tu `submission.csv`.
6. **Itera**: regulariza, cambia la arquitectura y ensambla.

</v-clicks>

<v-click>

> 📌 Recuerda reservar una **partición temporal** (nunca aleatoria) para medir sin mirar los 24 pasos finales.

</v-click>

---
layout: default
---

<v-click>

# Ideas para Mejorar

</v-click>

<div class="grid grid-cols-2 gap-4 mt-6">
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-amber-600 dark:text-amber-400 text-sm">🧱 Arquitectura</div>
<div class="text-xs text-slate-500 mt-1">Apila recurrentes (<i>return_sequences=True</i>), prueba GRU, <i>Bidirectional(LSTM)</i> o añade capas Dense/Dropout.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-rose-600 dark:text-rose-400 text-sm">🛡️ Regularización</div>
<div class="text-xs text-slate-500 mt-1">Dropout, EarlyStopping, <i>clipnorm</i> y un <i>learning-rate schedule</i> para estabilizar el entrenamiento.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-indigo-600 dark:text-indigo-400 text-sm">🧮 Variables exógenas</div>
<div class="text-xs text-slate-500 mt-1">Suavizado, rezagos (<i>lags</i>) y media móvil como entradas adicionales del modelo.</div>
</div>
<div v-click class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg">
<div class="font-bold text-emerald-600 dark:text-emerald-400 text-sm">🎯 Ensamble</div>
<div class="text-xs text-slate-500 mt-1">Promedia varios modelos o semillas para reducir la varianza del pronóstico.</div>
</div>
</div>

---
layout: two-cols
---

<v-click>

# Preguntas Frecuentes

</v-click>

<v-click>

### Lo que suele preguntarse antes de entregar

</v-click>

**¿Puedo usar otra arquitectura?**
Sí. Cualquier red neuronal es válida: RNN, LSTM, GRU, CNN 1D o una combinación.

**¿Qué hago si no conozco la respuesta?**
Es una competencia ciega. Mide en tu validación temporal y compara contra la persistencia.

::right::

**¿Cuántas veces puedo entregar?**
Todas las que quieras antes del cierre; nosotros evaluamos **tu mejor entrega**.

**¿Y si obtengo un RMSE casi perfecto?**
Se audita el notebook y las semillas. Si no hay entrenamiento real, no hay certificado.

**¿Puedo mirar datos “futuros”?**
No. Cualquier fuga del futuro es hacer trampa y el *skill* deja de tener sentido.

---
layout: default
class: text-center
---

<v-click>

# 🧠 Diseña, Mide y Documenta

</v-click>

<v-click>

### El cierre del seminario es tu primer *leaderboard* real

</v-click>

<div class="max-w-xl mx-auto mt-6 p-6 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-2xl text-left text-sm space-y-3">
<div v-click class="flex items-center gap-3">
<div class="w-9 h-9 rounded-xl bg-amber-100 dark:bg-amber-950 flex items-center justify-center text-amber-600 text-lg">1</div>
<div><b>Explora</b> · entiende la serie antes de modelar.</div>
</div>
<div v-click class="flex items-center gap-3">
<div class="w-9 h-9 rounded-xl bg-rose-100 dark:bg-rose-950 flex items-center justify-center text-rose-600 text-lg">2</div>
<div><b>Compite</b> · supera a la persistencia con una red bien regularizada.</div>
</div>
<div v-click class="flex items-center gap-3">
<div class="w-9 h-9 rounded-xl bg-emerald-100 dark:bg-emerald-950 flex items-center justify-center text-emerald-600 text-lg">3</div>
<div><b>Documenta</b> · guarda semillas, curvas de entrenamiento y decisiones.</div>
</div>
</div>

<v-click>

<div class="mt-8 opacity-70 text-sm">
Referencias: Hochreiter &amp; Schmidhuber (1997) · Cho et al. (2014) · Chollet (2021)<br>
DEEP LEARNING · Pontificia Universidad Javeriana Cali — <strong>Jan Polanco Velasco</strong>
</div>

</v-click>
