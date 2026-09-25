<script setup lang="ts">
import { ref, computed } from 'vue'
import katex from 'katex'

type StepType = 'all' | 'forward' | 'backward' | 'fusion'
const activeStep = ref<StepType>('all')

// Renderizado con KaTeX oficial de Slidev
const m = (expr: string) => {
  try {
    return katex.renderToString(expr, { throwOnError: false })
  } catch {
    return expr
  }
}

// Estructura limpia de datos para evitar repetición manual de HTML
const rows = [
  { id: '1', x: 'x_1', hFwd: '\\overrightarrow{h}_1', hBwd: '\\overleftarrow{h}_1', y: '\\hat{y}_1', top: 38 },
  { id: '2', x: 'x_2', hFwd: '\\overrightarrow{h}_2', hBwd: '\\overleftarrow{h}_2', y: '\\hat{y}_2', top: 118 },
  { id: 'T', x: 'x_T', hFwd: '\\overrightarrow{h}_T', hBwd: '\\overleftarrow{h}_T', y: '\\hat{y}_T', top: 208 }
]

const currentExplanation = computed(() => {
  switch (activeStep.value) {
    case 'all':
      return 'Arquitectura Bidireccional Completa: Flujo simultáneo hacia adelante y hacia atrás.'
    case 'forward':
      return `1. Paso Forward (${m('\\overrightarrow{h}')}): Lee la secuencia en orden cronológico (${m('t=1 \\to T')}).`
    case 'backward':
      return `2. Paso Backward (${m('\\overleftarrow{h}')}): Lee la secuencia en orden inverso (${m('t=T \\to 1')}).`
    case 'fusion':
      return `3. Fusión: En cada instante ${m('t')}, se combinan ${m('[\\overrightarrow{h}_t, \\overleftarrow{h}_t]')} para calcular ${m('\\hat{y}_t')}.`
  }
})
</script>

<template>
  <div class="flex flex-col items-center bg-white/90 dark:bg-zinc-900/90 p-3 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[410px]">
    
    <!-- Botones de Control -->
    <div class="flex gap-1 justify-center mb-2 w-full">
      <button 
        v-for="(label, key) in { all: 'Todo', forward: '1. Forward', backward: '2. Backward', fusion: '3. Fusión ŷ' }"
        :key="key"
        @click="activeStep = key as StepType"
        class="px-2 py-0.5 text-[10px] rounded-md font-medium transition"
        :class="activeStep === key ? 'bg-indigo-600 text-white shadow-sm font-bold' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300 hover:bg-slate-200'"
      >
        {{ label }}
      </button>
    </div>

    <!-- Lienzo Calibrado -->
    <div class="relative select-none" style="width: 320px; height: 295px;">

      <!-- CAPA 1: CONEXIONES VECTORIALES -->
      <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 320 295">
        <defs>
          <marker id="arr-gray" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" class="fill-slate-400 dark:fill-zinc-500" />
          </marker>
          <marker id="arr-fwd" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" fill="#6366f1" />
          </marker>
          <marker id="arr-bwd" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" fill="#f97316" />
          </marker>
          <marker id="arr-out" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" fill="#e11d48" />
          </marker>
        </defs>

        <!-- Flechas iniciales -->
        <line x1="135" y1="18" x2="135" y2="30" stroke="#6366f1" stroke-width="1.8" marker-end="url(#arr-fwd)" :class="{ 'opacity-20': activeStep === 'backward' }" />
        <line x1="135" y1="268" x2="135" y2="250" stroke="#f97316" stroke-width="1.8" marker-end="url(#arr-bwd)" :class="{ 'opacity-20': activeStep === 'forward' }" />

        <!-- x -> celdas -->
        <g :class="{ 'opacity-20': activeStep === 'fusion' }">
          <line x1="46" y1="54" x2="108" y2="43" stroke="#94a3b8" stroke-width="1.2" marker-end="url(#arr-gray)" />
          <line x1="46" y1="54" x2="108" y2="67" stroke="#94a3b8" stroke-width="1.2" marker-end="url(#arr-gray)" />
          
          <line x1="46" y1="134" x2="108" y2="123" stroke="#94a3b8" stroke-width="1.2" marker-end="url(#arr-gray)" />
          <line x1="46" y1="134" x2="108" y2="147" stroke="#94a3b8" stroke-width="1.2" marker-end="url(#arr-gray)" />
          
          <line x1="46" y1="224" x2="108" y2="213" stroke="#94a3b8" stroke-width="1.2" marker-end="url(#arr-gray)" />
          <line x1="46" y1="224" x2="108" y2="237" stroke="#94a3b8" stroke-width="1.2" marker-end="url(#arr-gray)" />
        </g>

        <!-- celdas -> y_hat -->
        <g :class="{ 'opacity-20': activeStep === 'forward' || activeStep === 'backward' }">
          <line x1="162" y1="43" x2="224" y2="54" stroke="#e11d48" stroke-width="1.5" marker-end="url(#arr-out)" />
          <line x1="162" y1="67" x2="224" y2="54" stroke="#e11d48" stroke-width="1.5" marker-end="url(#arr-out)" />

          <line x1="162" y1="123" x2="224" y2="134" stroke="#e11d48" stroke-width="1.5" marker-end="url(#arr-out)" />
          <line x1="162" y1="147" x2="224" y2="134" stroke="#e11d48" stroke-width="1.5" marker-end="url(#arr-out)" />

          <line x1="162" y1="213" x2="224" y2="224" stroke="#e11d48" stroke-width="1.5" marker-end="url(#arr-out)" />
          <line x1="162" y1="237" x2="224" y2="224" stroke="#e11d48" stroke-width="1.5" marker-end="url(#arr-out)" />
        </g>

        <!-- Curvas Forward -->
        <g :class="{ 'opacity-20': activeStep === 'backward' }">
          <path d="M 162 43 C 188 43, 188 123, 164 123" fill="none" stroke="#6366f1" stroke-width="2" marker-end="url(#arr-fwd)" />
          <path d="M 162 123 C 188 123, 188 213, 164 213" fill="none" stroke="#6366f1" stroke-width="2" marker-end="url(#arr-fwd)" />
        </g>

        <!-- Curvas Backward -->
        <g :class="{ 'opacity-20': activeStep === 'forward' }">
          <path d="M 108 237 C 82 237, 82 147, 106 147" fill="none" stroke="#f97316" stroke-width="2" marker-end="url(#arr-bwd)" />
          <path d="M 108 147 C 82 147, 82 67, 106 67" fill="none" stroke="#f97316" stroke-width="2" marker-end="url(#arr-bwd)" />
        </g>
      </svg>

      <!-- Estados Iniciales con KaTeX -->
      <div 
        class="absolute text-center text-xs font-bold text-indigo-700 dark:text-indigo-300 leading-none"
        style="left: 80px; top: 2px; width: 110px;"
        :class="{ 'opacity-20': activeStep === 'backward' }"
        v-html="m('\\overrightarrow{h}_0 = 0')"
      ></div>

      <div 
        class="absolute text-center text-xs font-bold text-amber-700 dark:text-amber-400 leading-none"
        style="left: 80px; top: 272px; width: 110px;"
        :class="{ 'opacity-20': activeStep === 'forward' }"
        v-html="m('\\overleftarrow{h}_0 = 0')"
      ></div>

      <!-- Filas de Nodos con v-for seguro y KaTeX real -->
      <template v-for="row in rows" :key="row.id">
        <!-- Entrada x -->
        <div 
          class="absolute rounded-full border-2 border-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 text-emerald-950 dark:text-emerald-100 flex items-center justify-center text-xs font-bold shadow-sm"
          :style="{ left: '14px', top: `${row.top}px`, width: '32px', height: '32px' }"
          v-html="m(row.x)"
        ></div>

        <!-- Celda Forward (h_t ->) -->
        <div 
          class="absolute rounded border border-indigo-600 bg-indigo-100 dark:bg-indigo-950/80 text-indigo-950 dark:text-indigo-200 flex items-center justify-center text-xs font-bold shadow-sm"
          :style="{ left: '108px', top: `${row.top - 6}px`, width: '54px', height: '22px' }"
          :class="{ 'opacity-20': activeStep === 'backward' }"
          v-html="m(row.hFwd)"
        ></div>

        <!-- Celda Backward (h_t <-) -->
        <div 
          class="absolute rounded border border-amber-600 bg-amber-100 dark:bg-amber-950/80 text-amber-950 dark:text-amber-200 flex items-center justify-center text-xs font-bold shadow-sm"
          :style="{ left: '108px', top: `${row.top + 18}px`, width: '54px', height: '22px' }"
          :class="{ 'opacity-20': activeStep === 'forward' }"
          v-html="m(row.hBwd)"
        ></div>

        <!-- Salida y_hat -->
        <div 
          class="absolute rounded-full border-2 border-rose-600 bg-rose-100 dark:bg-rose-950/60 text-rose-950 dark:text-rose-100 flex items-center justify-center text-xs font-bold shadow-sm overflow-hidden"
          :style="{ left: '224px', top: `${row.top}px`, width: '32px', height: '32px' }"
          :class="{ 'opacity-20': activeStep === 'forward' || activeStep === 'backward' }"
        >
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-rose-400 rotate-45"></div>
          <span class="relative z-10" v-html="m(row.y)"></span>
        </div>
      </template>

      <!-- Puntos suspensivos -->
      <div class="absolute text-slate-400 font-bold text-sm" style="left: 26px; top: 164px;">⋮</div>
      <div class="absolute text-slate-400 font-bold text-sm" style="left: 131px; top: 164px;">⋮</div>
      <div class="absolute text-slate-400 font-bold text-sm" style="left: 236px; top: 164px;">⋮</div>

    </div>

    <!-- Leyenda inferior interactiva con KaTeX -->
    <div 
      class="w-full mt-1.5 p-2 rounded-xl bg-slate-50 dark:bg-zinc-800/80 border border-slate-200 dark:border-zinc-700 text-[11px] leading-snug text-slate-700 dark:text-zinc-200 text-center"
      v-html="currentExplanation"
    ></div>

  </div>
</template>