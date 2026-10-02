<script setup lang="ts">
import { ref, computed } from 'vue'

type DiagnosticType = 'overfit' | 'underfit' | 'good' | 'exploding' | 'vanishing'

interface Diagnostic {
  label: string
  title: string
  badge: string
  badgeColor: string
  desc: string
  solution: string
  trainPath: string
  valPath: string
  criticalX: number | null
  criticalY: number | null
  showGap: boolean
  nan: boolean
  gradNorms: number[]
  gradLabel: string
  accent: string
}

// Orden de los botones (4 patologías + ajuste ideal)
const tabOrder: DiagnosticType[] = ['overfit', 'underfit', 'good', 'exploding', 'vanishing']

const diagnostics: Record<DiagnosticType, Diagnostic> = {
  overfit: {
    label: '1. Overfitting',
    title: 'Sobreajuste (Alta Varianza)',
    badge: 'Más común',
    badgeColor: 'bg-rose-100 text-rose-800 dark:bg-rose-950 dark:text-rose-300',
    desc: 'La pérdida de entrenamiento sigue bajando (memorización) mientras la de validación se estanca y repunta: surge el generalization gap.',
    solution: 'Receta: Dropout (0.2–0.5), Early Stopping, Data Augmentation o reducir parámetros.',
    trainPath: 'M 30 50 Q 120 180 270 215',
    valPath: 'M 30 65 Q 110 160 150 170 Q 210 190 270 90',
    criticalX: 150,
    criticalY: 170,
    showGap: true,
    nan: false,
    gradNorms: [0.45, 0.5, 0.55, 0.6],
    gradLabel: 'norma moderada',
    accent: '#f43f5e',
  },
  underfit: {
    label: '2. Underfitting',
    title: 'Subajuste (Alto Sesgo)',
    badge: 'Modelo incapaz',
    badgeColor: 'bg-amber-100 text-amber-800 dark:bg-amber-950 dark:text-amber-300',
    desc: 'Train y validación se estancan en valores inaceptablemente altos. La red no tiene capacidad suficiente para capturar la señal.',
    solution: 'Receta: Aumentar profundidad/capacidad, usar activaciones no lineales (ReLU) y entrenar más épocas.',
    trainPath: 'M 30 50 Q 80 100 270 120',
    valPath: 'M 30 60 Q 90 115 270 135',
    criticalX: null,
    criticalY: null,
    showGap: false,
    nan: false,
    gradNorms: [0.2, 0.22, 0.2, 0.18],
    gradLabel: 'norma pequeña y plana',
    accent: '#f59e0b',
  },
  good: {
    label: '3. Good Fit',
    title: 'Ajuste Óptimo (Good Fit)',
    badge: 'Objetivo ideal',
    badgeColor: 'bg-emerald-100 text-emerald-800 dark:bg-emerald-950 dark:text-emerald-300',
    desc: 'Ambas curvas descienden y se estabilizan con una brecha mínima y constante. El modelo generaliza correctamente.',
    solution: 'Receta: Punto dulce de capacidad y regularización alcanzado.',
    trainPath: 'M 30 50 Q 110 175 270 210',
    valPath: 'M 30 65 Q 120 165 270 198',
    criticalX: null,
    criticalY: null,
    showGap: false,
    nan: false,
    gradNorms: [0.5, 0.55, 0.5, 0.45],
    gradLabel: 'norma estable',
    accent: '#10b981',
  },
  exploding: {
    label: '4. Explotan',
    title: 'Gradientes que Explotan',
    badge: 'NaN / divergencia',
    badgeColor: 'bg-purple-100 text-purple-800 dark:bg-purple-950 dark:text-purple-300',
    desc: 'Actualizaciones de pesos gigantescas provocan oscilaciones caóticas; la pérdida se dispara a NaN de forma repentina.',
    solution: 'Receta: Gradient Clipping (clipnorm/clipvalue), reducir el Learning Rate y normalizar las entradas.',
    trainPath: 'M 30 70 Q 80 150 120 160 L 140 60 L 170 230 L 210 20 L 270 240',
    valPath: 'M 30 85 Q 85 140 120 150 L 145 40 L 175 240 L 215 10 L 270 250',
    criticalX: null,
    criticalY: null,
    showGap: false,
    nan: true,
    gradNorms: [1.0, 0.85, 0.62, 0.35],
    gradLabel: 'crece hacia la entrada',
    accent: '#a855f7',
  },
  vanishing: {
    label: '5. Se desvanecen',
    title: 'Gradientes que se Desvanecen',
    badge: 'Amnesia profunda',
    badgeColor: 'bg-sky-100 text-sky-800 dark:bg-sky-950 dark:text-sky-300',
    desc: 'Al retropropagar por muchas capas, ‖∇W‖ se atenúa exponencialmente hasta ~0: las primeras capas dejan de aprender.',
    solution: 'Receta: ReLU/GELU, Batch Normalization, conexiones residuales (skip connections) e inicialización He/Xavier.',
    trainPath: 'M 30 55 Q 90 130 160 150 Q 220 165 270 172',
    valPath: 'M 30 70 Q 95 140 165 158 Q 225 172 270 178',
    criticalX: null,
    criticalY: null,
    showGap: false,
    nan: false,
    gradNorms: [0.05, 0.15, 0.42, 0.85],
    gradLabel: 'se apaga hacia la entrada',
    accent: '#0ea5e9',
  },
}

const activeCase = ref<DiagnosticType>('overfit')
const current = computed(() => diagnostics[activeCase.value])

// Altura en px de cada barra del perfil de gradiente (mínimo visible de 4px)
const barHeight = (g: number) => 4 + g * 26
</script>

<template>
  <div class="flex flex-col items-center bg-white/90 dark:bg-zinc-900/90 p-3.5 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[428px]">

    <!-- Barra de selección de patologías -->
    <div class="grid grid-cols-3 gap-1.5 w-full mb-2.5">
      <button v-for="key in tabOrder" :key="key" @click="activeCase = key"
        class="py-1 px-2 text-[11px] rounded-lg font-medium transition text-center leading-tight"
        :class="activeCase === key ? 'bg-indigo-600 text-white shadow-sm' : 'bg-slate-100 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300 hover:bg-slate-200 dark:hover:bg-zinc-700'">
        {{ diagnostics[key].label }}
      </button>
    </div>

    <!-- Lienzo del Gráfico Vectorial -->
    <div class="relative w-full h-[176px]">
      <svg viewBox="0 0 300 240" class="w-full h-full">
        <defs>
          <marker id="tcd-arr-axis" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" class="fill-slate-700 dark:fill-zinc-300" />
          </marker>
          <marker id="tcd-arr-gap" viewBox="0 0 10 10" refX="5" refY="3" markerWidth="5" markerHeight="5" orient="auto-start-reverse">
            <path d="M 0 0 L 6 3 L 0 6 z" class="fill-rose-500" />
          </marker>
        </defs>

        <!-- Ejes cartesianos -->
        <line x1="25" y1="220" x2="290" y2="220" class="stroke-slate-700 dark:stroke-zinc-300" stroke-width="1.8" marker-end="url(#tcd-arr-axis)" />
        <line x1="25" y1="220" x2="25" y2="20" class="stroke-slate-700 dark:stroke-zinc-300" stroke-width="1.8" marker-end="url(#tcd-arr-axis)" />
        <text x="290" y="235" class="text-[10px] fill-slate-500 font-bold" text-anchor="end">Épocas</text>
        <text x="20" y="14" class="text-[10px] fill-slate-500 font-bold">Pérdida</text>

        <!-- Línea de Entrenamiento (Azul) -->
        <path :d="current.trainPath" fill="none" stroke="#3b82f6" stroke-width="2.5" stroke-linecap="round" />
        <!-- Línea de Validación (Rojo) -->
        <path :d="current.valPath" fill="none" stroke="#ef4444" stroke-width="2.5" stroke-linecap="round" />

        <!-- Anotación del generalization gap (overfitting) -->
        <g v-if="current.showGap" class="stroke-rose-500" stroke-width="1.4">
          <line x1="276" y1="90" x2="276" y2="215" marker-start="url(#tcd-arr-gap)" marker-end="url(#tcd-arr-gap)" />
          <text x="272" y="150" class="fill-rose-500 text-[10px] font-bold" text-anchor="end" stroke="none">Gap</text>
        </g>

        <!-- Punto de corte de Early Stopping -->
        <g v-if="current.criticalX">
          <line :x1="current.criticalX" y1="35" :x2="current.criticalX" y2="220" stroke="#f59e0b" stroke-width="1.5" stroke-dasharray="4 4" />
          <circle :cx="current.criticalX" :cy="current.criticalY" r="5" class="fill-amber-500 stroke-white dark:stroke-zinc-900" stroke-width="2" />
          <text :x="current.criticalX + 6" y="52" class="text-[10px] font-bold fill-amber-600 dark:fill-amber-400 font-mono">Early Stopping</text>
        </g>

        <!-- Marca de NaN (gradientes que explotan) -->
        <g v-if="current.nan">
          <text x="228" y="26" class="fill-purple-600 dark:fill-purple-400 text-[13px] font-black font-mono">NaN</text>
          <text x="228" y="38" class="fill-purple-500 text-[8px] font-bold">loss → ∞</text>
        </g>
      </svg>

      <!-- Leyenda de colores -->
      <div class="absolute right-2 top-2 flex gap-3 text-[10px] font-semibold bg-white/85 dark:bg-zinc-800/85 px-2 py-0.5 rounded-md border border-slate-200 dark:border-zinc-700">
        <span class="flex items-center gap-1 text-blue-600 dark:text-blue-400">
          <span class="w-2.5 h-0.5 bg-blue-500 inline-block"></span> Train
        </span>
        <span class="flex items-center gap-1 text-red-600 dark:text-red-400">
          <span class="w-2.5 h-0.5 bg-red-500 inline-block"></span> Validation
        </span>
      </div>
    </div>

    <!-- Perfil del gradiente por capa -->
    <div class="w-full mt-1.5 p-2 rounded-xl border border-slate-200 dark:border-zinc-700 bg-slate-50 dark:bg-zinc-800/50">
      <div class="flex items-center justify-between text-[10px] font-bold text-slate-500 dark:text-zinc-400">
        <span>Perfil de ‖∇W‖ por capa (entrada → salida)</span>
        <span :style="{ color: current.accent }">{{ current.gradLabel }}</span>
      </div>
      <div class="flex items-end gap-1 h-9 mt-1">
        <div v-for="(g, i) in current.gradNorms" :key="i" class="flex-1 rounded-t flex flex-col items-center justify-end"
          :style="{ height: barHeight(g) + 'px', backgroundColor: current.accent, opacity: 0.35 + g * 0.65 }">
          <span class="text-[8px] font-mono font-bold text-white/90 mb-0.5">L{{ i + 1 }}</span>
        </div>
      </div>
    </div>

    <!-- Diagnóstico clínico y receta -->
    <div class="w-full mt-2 p-2.5 rounded-xl bg-slate-50 dark:bg-zinc-800/70 border border-slate-200 dark:border-zinc-700 text-xs">
      <div class="flex items-center justify-between mb-1 gap-2">
        <span class="font-bold text-slate-800 dark:text-zinc-100 text-[12px] leading-tight">{{ current.title }}</span>
        <span class="shrink-0 text-[9px] px-2 py-0.5 rounded-full font-bold uppercase tracking-wider" :class="current.badgeColor">
          {{ current.badge }}
        </span>
      </div>
      <p class="text-slate-600 dark:text-zinc-300 text-[11px] leading-snug">{{ current.desc }}</p>
      <div class="mt-1 pt-1 border-t border-slate-200 dark:border-zinc-700/60 font-medium text-[11px] text-indigo-700 dark:text-indigo-300">
        {{ current.solution }}
      </div>
    </div>

  </div>
</template>
