<script setup lang="ts">
import { ref, computed } from 'vue'

type PoolMode = 'max' | 'avg' | 'gap'

const mode = ref<PoolMode>('max')
const activeQuadrant = ref<number | null>(null)

// Matriz de entrada 4x4 (inspirada en el ejemplo numérico del PDF de Pooling)
const inputMatrix = [
  [5, 6, 6, 5],
  [9, 1, 2, 8],
  [4, 7, 1, 8],
  [3, 2, 2, 7],
]

// Cuadrantes 2x2 (filtro f = 2, stride s = 2)
const quadrants = [
  { id: 0, r: [0, 1], c: [0, 1], color: 'bg-amber-100 border-amber-300 dark:bg-amber-950/40 dark:border-amber-700' },
  { id: 1, r: [0, 1], c: [2, 3], color: 'bg-emerald-100 border-emerald-300 dark:bg-emerald-950/40 dark:border-emerald-700' },
  { id: 2, r: [2, 3], c: [0, 1], color: 'bg-blue-100 border-blue-300 dark:bg-blue-950/40 dark:border-blue-700' },
  { id: 3, r: [2, 3], c: [2, 3], color: 'bg-rose-100 border-rose-300 dark:bg-rose-950/40 dark:border-rose-700' },
]

const getQuadrantId = (row: number, col: number) => {
  if (row < 2 && col < 2) return 0
  if (row < 2 && col >= 2) return 1
  if (row >= 2 && col < 2) return 2
  return 3
}

const quadrantValues = (q: (typeof quadrants)[number]) =>
  q.r.flatMap((r) => q.c.map((c) => inputMatrix[r][c]))

const round2 = (v: number) => Math.round(v * 100) / 100

// Salida dinámica: Max, Average 2x2 (f=2,s=2) o Global Average (1x1)
const poolResults = computed<number[][]>(() => {
  if (mode.value === 'gap') {
    const all = inputMatrix.flat()
    const mean = all.reduce((a, b) => a + b, 0) / all.length
    return [[round2(mean)]]
  }
  const out: number[][] = [
    [0, 0],
    [0, 0],
  ]
  quadrants.forEach((q) => {
    const vals = quadrantValues(q)
    const v = mode.value === 'max' ? Math.max(...vals) : vals.reduce((a, b) => a + b, 0) / vals.length
    out[Math.floor(q.id / 2)][q.id % 2] = round2(v)
  })
  return out
})

const operatorLabel = computed(() => (mode.value === 'max' ? 'max()' : mode.value === 'avg' ? 'mean()' : 'mean(16)'))
</script>

<template>
  <div class="flex flex-col items-center bg-white/90 dark:bg-zinc-900/90 p-2.5 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[430px]">

    <!-- Encabezado: filtro/stride + selector de modo -->
    <div class="flex items-center justify-between w-full mb-2 gap-2 flex-wrap">
      <div class="text-[11px] font-mono font-bold text-slate-700 dark:text-zinc-200">
        Filtro f&nbsp;=&nbsp;2×2 &nbsp;|&nbsp; Stride s&nbsp;=&nbsp;2
      </div>
      <div class="flex gap-1">
        <button @click="mode = 'max'"
          class="px-2 py-1 text-[11px] rounded-lg font-bold transition"
          :class="mode === 'max' ? 'bg-indigo-600 text-white shadow-sm' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300'">
          Max
        </button>
        <button @click="mode = 'avg'"
          class="px-2 py-1 text-[11px] rounded-lg font-bold transition"
          :class="mode === 'avg' ? 'bg-indigo-600 text-white shadow-sm' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300'">
          Average
        </button>
        <button @click="mode = 'gap'"
          class="px-2 py-1 text-[11px] rounded-lg font-bold transition"
          :class="mode === 'gap' ? 'bg-indigo-600 text-white shadow-sm' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300'">
          Global
        </button>
      </div>
    </div>

    <!-- Área de transformación: entrada 4x4 -> salida -->
    <div class="flex items-center justify-center gap-3 w-full py-1">

      <!-- Matriz de entrada 4x4 -->
      <div class="flex flex-col items-center">
        <div class="text-[11px] font-mono text-slate-500 mb-1">Entrada (4 × 4)</div>
        <div class="grid grid-cols-4 gap-1 p-1.5 rounded-xl bg-slate-50 dark:bg-zinc-950 border border-slate-200 dark:border-zinc-800">
          <template v-for="(row, rIdx) in inputMatrix" :key="rIdx">
            <div v-for="(val, cIdx) in row" :key="cIdx"
              @mouseenter="activeQuadrant = getQuadrantId(rIdx, cIdx)"
              @mouseleave="activeQuadrant = null"
              class="w-7 h-7 flex items-center justify-center font-mono font-bold text-xs rounded cursor-pointer transition-all duration-150 border"
              :class="[
                quadrants[getQuadrantId(rIdx, cIdx)].color,
                activeQuadrant === getQuadrantId(rIdx, cIdx) ? 'ring-2 ring-indigo-500 scale-105 shadow-md font-extrabold' : '',
              ]">
              {{ val }}
            </div>
          </template>
        </div>
      </div>

      <!-- Flecha de operación -->
      <div class="flex flex-col items-center justify-center px-1">
        <span class="text-[11px] font-mono font-bold text-indigo-600 dark:text-indigo-400">{{ operatorLabel }}</span>
        <span class="text-xl text-slate-400">➔</span>
      </div>

      <!-- Matriz de salida -->
      <div class="flex flex-col items-center">
        <div class="text-[11px] font-mono text-slate-500 mb-1">
          {{ mode === 'gap' ? 'Salida (1 × 1)' : 'Salida (2 × 2)' }}
        </div>

        <div v-if="mode === 'gap'"
          class="w-[62px] h-[62px] flex items-center justify-center rounded-xl border border-indigo-300 dark:border-indigo-700 bg-gradient-to-br from-indigo-100 to-purple-100 dark:from-indigo-950/60 dark:to-purple-950/60 font-mono font-black text-sm text-indigo-700 dark:text-indigo-200">
          {{ poolResults[0][0] }}
        </div>

        <div v-else class="grid grid-cols-2 gap-1 p-1.5 rounded-xl bg-slate-50 dark:bg-zinc-950 border border-slate-200 dark:border-zinc-800">
          <div v-for="(q, qIdx) in quadrants" :key="q.id"
            @mouseenter="activeQuadrant = q.id" @mouseleave="activeQuadrant = null"
            class="w-11 h-11 flex items-center justify-center font-mono font-bold text-xs rounded transition-all duration-200 border cursor-pointer"
            :class="[
              q.color,
              activeQuadrant === q.id ? 'ring-2 ring-indigo-500 scale-110 shadow-lg font-black' : '',
            ]">
            {{ poolResults[Math.floor(qIdx / 2)][qIdx % 2] }}
          </div>
        </div>
      </div>

    </div>

    <!-- Leyenda matemática y explicación -->
    <div class="w-full mt-1.5 p-2 rounded-xl bg-slate-100 dark:bg-zinc-800/80 border border-slate-200 dark:border-zinc-700 text-xs">
      <div class="font-bold text-slate-800 dark:text-zinc-100 flex justify-between gap-2">
        <span v-if="mode === 'max'">Max Pooling: activación dominante</span>
        <span v-else-if="mode === 'avg'">Average Pooling: suavizado contextual</span>
        <span v-else>Global Average Pooling (GAP)</span>
        <span class="font-mono text-indigo-600 dark:text-indigo-400 text-[10px] shrink-0">
          {{ mode === 'gap' ? '16 → 1' : '4×4 → 2×2' }}
        </span>
      </div>
      <p class="text-slate-600 dark:text-zinc-300 text-[11px] mt-0.5 leading-snug">
        <span v-if="mode === 'max'">
          Captura la activación más prominente de cada región. Aporta <strong>invarianza a la traslación</strong> y reduce el cómputo de las capas siguientes.
        </span>
        <span v-else-if="mode === 'avg'">
          Calcula la media aritmética del cuadrante. Suaviza el mapa de características y conserva el contexto de la región.
        </span>
        <span v-else>
          Colapsa todo el mapa a un único valor por canal. Reemplaza al <code>Flatten()</code> antes de la capa <strong>Softmax</strong>, reduciendo drásticamente los parámetros.
        </span>
      </p>
    </div>

  </div>
</template>
