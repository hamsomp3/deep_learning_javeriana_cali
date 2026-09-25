
<script setup lang="ts">
import { ref } from 'vue'

type GateType = 'all' | 'forget' | 'input' | 'cell' | 'output'
const activeGate = ref<GateType>('all')

const gateInfo = {
  all: {
    title: 'Celda de Memoria LSTM Completa',
    desc: 'Regula el flujo de información a través de 3 compuertas sigmoides (σ) y una autopista de estado celular (Ct).',
    formulaHtml: '<i>C</i><sub>t</sub> = <i>f</i><sub>t</sub> ⊙ <i>C</i><sub>t-1</sub> + <i>i</i><sub>t</sub> ⊙ <i>C̃</i><sub>t</sub> &nbsp;&nbsp;;&nbsp;&nbsp; <i>h</i><sub>t</sub> = <i>o</i><sub>t</sub> ⊙ tanh(<i>C</i><sub>t</sub>)'
  },
  forget: {
    title: '1. Compuerta de Olvido (Forget Gate)',
    desc: 'Decide qué porcentaje de la memoria pasada (Ct-1) se descarta. Si ft ≈ 0, se olvida; si ft ≈ 1, se preserva intacto.',
    formulaHtml: '<i>f</i><sub>t</sub> = σ(<i>W</i><sub>f</sub> · [<i>h</i><sub>t-1</sub>, <i>x</i><sub>t</sub>] + <i>b</i><sub>f</sub>)'
  },
  input: {
    title: '2. Compuerta de Entrada y Candidato (Input Gate)',
    desc: 'it decide qué valores actualizar. C̃t genera un vector con nuevos contenidos candidatos entre -1 y 1.',
    formulaHtml: '<i>i</i><sub>t</sub> = σ(<i>W</i><sub>i</sub> · [<i>h</i><sub>t-1</sub>, <i>x</i><sub>t</sub>] + <i>b</i><sub>i</sub>) &nbsp;&nbsp;;&nbsp;&nbsp; <i>C̃</i><sub>t</sub> = tanh(<i>W</i><sub>c</sub> · [<i>h</i><sub>t-1</sub>, <i>x</i><sub>t</sub>] + <i>b</i><sub>c</sub>)'
  },
  cell: {
    title: '3. Actualización del Estado Celular (Cell State)',
    desc: 'La "autopista lineal": combina el pasado filtrado por el olvido más la nueva información ponderada.',
    formulaHtml: '<i>C</i><sub>t</sub> = <i>f</i><sub>t</sub> ⊙ <i>C</i><sub>t-1</sub> + <i>i</i><sub>t</sub> ⊙ <i>C̃</i><sub>t</sub>'
  },
  output: {
    title: '4. Compuerta de Salida (Output Gate)',
    desc: 'ot decide qué partes del estado de celda pasan al estado oculto ht, modulado por tanh.',
    formulaHtml: '<i>o</i><sub>t</sub> = σ(<i>W</i><sub>o</sub> · [<i>h</i><sub>t-1</sub>, <i>x</i><sub>t</sub>] + <i>b</i><sub>o</sub>) &nbsp;&nbsp;;&nbsp;&nbsp; <i>h</i><sub>t</sub> = <i>o</i><sub>t</sub> ⊙ tanh(<i>C</i><sub>t</sub>)'
  }
}
</script>

<template>
  <div class="flex flex-col items-center bg-white/80 dark:bg-zinc-900/90 p-4 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[520px]">
    
    <!-- Selector Interactivo de Compuertas -->
    <div class="flex flex-wrap gap-1.5 justify-center mb-3">
      <button 
        v-for="(label, key) in { all: 'Celda Total', forget: '1. Olvido (f)', input: '2. Entrada (i)', cell: '3. Estado (C)', output: '4. Salida (o)' }"
        :key="key"
        @click="activeGate = key as GateType"
        class="px-2.5 py-1 text-xs rounded-lg font-medium transition"
        :class="activeGate === key ? 'bg-indigo-600 text-white shadow-md' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300 hover:bg-slate-300 dark:hover:bg-zinc-700'"
      >
        {{ label }}
      </button>
    </div>

    <!-- Diagrama Vectorial de la Celda LSTM -->
    <div class="relative w-[480px] h-[240px]">
      <svg viewBox="0 0 480 240" class="w-full h-full">
        <defs>
          <marker id="lstm-arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" class="fill-slate-800 dark:fill-zinc-200" />
          </marker>
        </defs>

        <!-- Caja contenedora de la celda -->
        <rect x="50" y="25" width="380" height="190" rx="20" class="fill-emerald-50/50 dark:fill-emerald-950/20 stroke-emerald-600 dark:stroke-emerald-500" stroke-width="2.5" />

        <!-- Autopista superior: Cell State (Ct-1 -> Ct) -->
        <line x1="20" y1="55" x2="455" y2="55" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.5" marker-end="url(#lstm-arrow)" />

        <!-- Entrada inferior: Línea de ht-1 y xt -->
        <path d="M 20 185 L 110 185 L 110 170" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.2" />
        <path d="M 75 225 L 75 185" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.2" />
        <path d="M 110 185 L 180 185 L 180 170" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.2" />
        <path d="M 180 185 L 250 185 L 250 170" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.2" />
        <path d="M 250 185 L 320 185 L 320 170" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.2" />

        <!-- LÍNEAS INTERNAS: Forget Gate a multiplicación superior -->
        <line x1="110" y1="130" x2="110" y2="67" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" marker-end="url(#lstm-arrow)" />

        <!-- LÍNEAS INTERNAS: Input Gate y Candidato al sumador -->
        <line x1="180" y1="130" x2="180" y2="105" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" />
        <line x1="250" y1="130" x2="250" y2="105" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" />
        <line x1="180" y1="105" x2="215" y2="105" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" />
        <line x1="250" y1="105" x2="215" y2="105" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" />
        <line x1="215" y1="95" x2="215" y2="67" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" marker-end="url(#lstm-arrow)" />

        <!-- LÍNEAS INTERNAS: Output Gate a multiplicación final -->
        <line x1="320" y1="130" x2="320" y2="100" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" />
        <path d="M 280 55 L 280 90 L 370 90 L 370 95" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" />
        <path d="M 320 100 L 360 100" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2" />

        <!-- Salida ht -->
        <path d="M 370 115 L 370 185 L 455 185" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.5" marker-end="url(#lstm-arrow)" />
        <path d="M 405 185 L 405 25" fill="none" class="stroke-slate-800 dark:stroke-zinc-200" stroke-width="2.5" marker-end="url(#lstm-arrow)" />

        <!-- OPERADORES MATEMÁTICOS -->
        <circle cx="110" cy="55" r="12" class="fill-rose-200 stroke-rose-600 dark:fill-rose-950 dark:stroke-rose-400" stroke-width="2" />
        <text x="110" y="59" text-anchor="middle" class="font-bold text-xs">×</text>

        <circle cx="215" cy="55" r="12" class="fill-rose-200 stroke-rose-600 dark:fill-rose-950 dark:stroke-rose-400" stroke-width="2" />
        <text x="215" y="59" text-anchor="middle" class="font-bold text-xs">+</text>

        <circle cx="215" cy="105" r="10" class="fill-rose-200 stroke-rose-600 dark:fill-rose-950 dark:stroke-rose-400" stroke-width="2" />
        <text x="215" y="108" text-anchor="middle" class="font-bold text-[10px]">×</text>

        <rect x="350" y="70" width="40" height="20" rx="6" class="fill-amber-100 stroke-amber-600 dark:fill-amber-950 dark:stroke-amber-400" stroke-width="1.5" />
        <text x="370" y="84" text-anchor="middle" class="font-serif italic text-[10px]">tanh</text>

        <circle cx="370" cy="115" r="10" class="fill-rose-200 stroke-rose-600 dark:fill-rose-950 dark:stroke-rose-400" stroke-width="2" />
        <text x="370" y="118" text-anchor="middle" class="font-bold text-[10px]">×</text>

        <!-- COMPUERTAS NEURONALES -->
        <g :class="{ 'opacity-30': activeGate !== 'all' && activeGate !== 'forget' }">
          <rect x="95" y="135" width="30" height="30" rx="5" class="fill-amber-200 stroke-amber-600 dark:fill-amber-900 dark:stroke-amber-400" stroke-width="2" />
          <text x="110" y="154" text-anchor="middle" class="font-serif font-bold text-sm">σ</text>
          <text x="90" y="115" class="font-serif italic text-xs fill-amber-700 dark:fill-amber-300">ft</text>
        </g>

        <g :class="{ 'opacity-30': activeGate !== 'all' && activeGate !== 'input' }">
          <rect x="165" y="135" width="30" height="30" rx="5" class="fill-amber-200 stroke-amber-600 dark:fill-amber-900 dark:stroke-amber-400" stroke-width="2" />
          <text x="180" y="154" text-anchor="middle" class="font-serif font-bold text-sm">σ</text>
          <text x="165" y="115" class="font-serif italic text-xs fill-amber-700 dark:fill-amber-300">it</text>
        </g>

        <g :class="{ 'opacity-30': activeGate !== 'all' && activeGate !== 'input' }">
          <rect x="232" y="135" width="36" height="30" rx="5" class="fill-amber-200 stroke-amber-600 dark:fill-amber-900 dark:stroke-amber-400" stroke-width="2" />
          <text x="250" y="154" text-anchor="middle" class="font-serif italic text-xs">tanh</text>
          <text x="255" y="115" class="font-serif italic text-xs fill-amber-700 dark:fill-amber-300">C̃t</text>
        </g>

        <g :class="{ 'opacity-30': activeGate !== 'all' && activeGate !== 'output' }">
          <rect x="305" y="135" width="30" height="30" rx="5" class="fill-amber-200 stroke-amber-600 dark:fill-amber-900 dark:stroke-amber-400" stroke-width="2" />
          <text x="320" y="154" text-anchor="middle" class="font-serif font-bold text-sm">σ</text>
          <text x="305" y="115" class="font-serif italic text-xs fill-amber-700 dark:fill-amber-300">ot</text>
        </g>
      </svg>

      <!-- Etiquetas Externas de Entrada y Salida -->
      <span class="absolute left-[2px] top-[46px] font-serif text-xs italic font-bold">Ct-1</span>
      <span class="absolute right-[2px] top-[46px] font-serif text-xs italic font-bold text-emerald-600 dark:text-emerald-400">Ct</span>
      <span class="absolute left-[2px] top-[175px] font-serif text-xs italic font-bold">ht-1</span>
      <span class="absolute right-[2px] top-[175px] font-serif text-xs italic font-bold text-emerald-600 dark:text-emerald-400">ht</span>
      <span class="absolute left-[65px] bottom-[2px] font-serif text-xs italic font-bold">xt</span>
      <span class="absolute right-[65px] top-[2px] font-serif text-xs italic font-bold text-emerald-600 dark:text-emerald-400">ht</span>
    </div>

    <!-- Panel de Explicación Didáctica y Ecuación Renderizada en HTML Matemático -->
    <div class="w-full mt-3 p-2.5 rounded-xl bg-slate-100 dark:bg-zinc-800/80 border border-slate-200 dark:border-zinc-700 text-xs">
      <div class="font-bold text-slate-800 dark:text-zinc-100">{{ gateInfo[activeGate].title }}</div>
      <p class="text-slate-600 dark:text-zinc-300 mt-0.5 leading-snug">{{ gateInfo[activeGate].desc }}</p>
      <div 
        class="mt-1.5 font-serif text-[13px] text-indigo-700 dark:text-indigo-300 font-medium tracking-wide"
        v-html="gateInfo[activeGate].formulaHtml"
      ></div>
    </div>

  </div>
</template>