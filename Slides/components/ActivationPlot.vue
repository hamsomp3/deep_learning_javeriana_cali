<script setup lang="ts">
import { ref, computed } from 'vue'

const props = withDefaults(defineProps<{
  type: 'identity' | 'sigmoid' | 'tanh' | 'relu'
}>(), {
  type: 'sigmoid'
})

// Control interactivo para evaluar f(x) en vivo
const testX = ref(props.type === 'sigmoid' ? 0.0 : props.type === 'tanh' ? 0.0 : 1.5)

// Funciones matemáticas y derivadas
const evalFunc = computed(() => {
  const x = testX.value
  switch (props.type) {
    case 'identity':
      return { y: x, dy: 1, name: 'f(x) = x', range: '(-∞, ∞)' }
    case 'sigmoid': {
      const s = 1 / (1 + Math.exp(-x))
      return { y: s, dy: s * (1 - s), name: 'σ(x)', range: '[0, 1]' }
    }
    case 'tanh': {
      const t = Math.tanh(x)
      return { y: t, dy: 1 - t * t, name: 'tanh(x)', range: '[-1, 1]' }
    }
    case 'relu':
      return { y: Math.max(0, x), dy: x > 0 ? 1 : 0, name: 'ReLU(x)', range: '[0, ∞)' }
  }
})

// Trazado de las curvas vectoriales según el tipo
const curvePath = computed(() => {
  let d = ''
  if (props.type === 'identity') {
    return 'M 60 230 L 260 30'
  } else if (props.type === 'sigmoid') {
    // x entre -6 y 6
    for (let x = -6; x <= 6; x += 0.2) {
      const sx = 160 + x * 22
      const s = 1 / (1 + Math.exp(-x))
      const sy = 195 - s * 130
      d += d === '' ? `M ${sx.toFixed(1)} ${sy.toFixed(1)}` : ` L ${sx.toFixed(1)} ${sy.toFixed(1)}`
    }
    return d
  } else if (props.type === 'tanh') {
    // x entre -4 y 4
    for (let x = -4; x <= 4; x += 0.15) {
      const sx = 160 + x * 32
      const t = Math.tanh(x)
      const sy = 130 - t * 75
      d += d === '' ? `M ${sx.toFixed(1)} ${sy.toFixed(1)}` : ` L ${sx.toFixed(1)} ${sy.toFixed(1)}`
    }
    return d
  } else if (props.type === 'relu') {
    return 'M 50 180 L 160 180 L 260 80'
  }
  return ''
})

// Coordenadas SVG del punto interactivo
const pointSvg = computed(() => {
  const x = testX.value
  const y = evalFunc.value.y
  if (props.type === 'identity') {
    return { cx: 160 + x * 33.3, cy: 130 - y * 33.3 }
  } else if (props.type === 'sigmoid') {
    return { cx: 160 + x * 22, cy: 195 - y * 130 }
  } else if (props.type === 'tanh') {
    return { cx: 160 + x * 32, cy: 130 - y * 75 }
  } else {
    return { cx: 160 + x * 25, cy: 180 - y * 25 }
  }
})
</script>

<template>
  <div class="flex flex-col items-center bg-white/85 dark:bg-zinc-900/85 p-3 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-lg backdrop-blur-sm select-none">
    
    <!-- Lienzo del Gráfico -->
    <div class="relative w-[300px] h-[240px]">
      <svg viewBox="0 0 320 250" class="w-full h-full pointer-events-none">
        <defs>
          <marker id="axis-arrow-act" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
            <path d="M 0 2 L 8 5 L 0 8 z" class="fill-slate-800 dark:fill-slate-200" />
          </marker>
        </defs>

        <!-- CASO 1: IDENTIDAD -->
        <template v-if="type === 'identity'">
          <line x1="20" y1="130" x2="305" y2="130" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
          <line x1="160" y1="240" x2="160" y2="15" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
        </template>

        <!-- CASO 2: SIGMOIDE (Eje horizontal en y=0, asíntota en y=1) -->
        <template v-else-if="type === 'sigmoid'">
          <line x1="20" y1="195" x2="305" y2="195" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
          <line x1="160" y1="240" x2="160" y2="15" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
          <!-- Asíntota horizontal en y=1 -->
          <line x1="160" y1="65" x2="295" y2="65" class="stroke-slate-400 dark:stroke-zinc-500" stroke-width="1.5" stroke-dasharray="4 4" />
          <text x="150" y="69" class="font-serif text-sm fill-slate-700 dark:fill-zinc-300" text-anchor="end">1</text>
        </template>

        <!-- CASO 3: TANH (Asíntotas en +1 y -1) -->
        <template v-else-if="type === 'tanh'">
          <line x1="20" y1="130" x2="305" y2="130" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
          <line x1="160" y1="240" x2="160" y2="15" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
          <!-- Asíntota en y=1 -->
          <line x1="160" y1="55" x2="285" y2="55" class="stroke-slate-400 dark:stroke-zinc-500" stroke-width="1.5" stroke-dasharray="4 4" />
          <text x="150" y="59" class="font-serif text-sm fill-slate-700 dark:fill-zinc-300" text-anchor="end">1</text>
          <!-- Asíntota en y=-1 -->
          <line x1="35" y1="205" x2="160" y2="205" class="stroke-slate-400 dark:stroke-zinc-500" stroke-width="1.5" stroke-dasharray="4 4" />
          <text x="170" y="209" class="font-serif text-sm fill-slate-700 dark:fill-zinc-300" text-anchor="start">-1</text>
        </template>

        <!-- CASO 4: RELU -->
        <template v-else-if="type === 'relu'">
          <line x1="20" y1="180" x2="305" y2="180" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
          <line x1="160" y1="240" x2="160" y2="15" class="stroke-slate-800 dark:stroke-slate-200" stroke-width="1.8" marker-end="url(#axis-arrow-act)" />
        </template>

        <!-- Curva Roja de Activación -->
        <path :d="curvePath" fill="none" stroke="#ef4444" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" />

        <!-- Punto interactivo sobre la curva -->
        <circle 
          v-if="pointSvg.cx >= 20 && pointSvg.cx <= 300 && pointSvg.cy >= 10 && pointSvg.cy <= 240"
          :cx="pointSvg.cx" 
          :cy="pointSvg.cy" 
          r="5" 
          class="fill-rose-600 stroke-white dark:stroke-zinc-900" 
          stroke-width="2" 
        />
      </svg>
    </div>

    <!-- Barra de Inspección Interactiva -->
    <div class="w-full mt-1 pt-2 border-t border-slate-200 dark:border-zinc-800 flex items-center justify-between text-xs font-mono">
      <div class="flex items-center gap-1.5">
        <span class="text-slate-500">x:</span>
        <input 
          type="range" 
          :min="type === 'sigmoid' ? -5 : type === 'tanh' ? -3.5 : -3" 
          :max="type === 'sigmoid' ? 5 : type === 'tanh' ? 3.5 : 3" 
          step="0.1" 
          v-model.number="testX" 
          class="w-20 accent-rose-500" 
        />
        <span class="w-7 text-right font-bold">{{ testX.toFixed(1) }}</span>
      </div>

      <div class="flex items-center gap-2">
        <span>f(x) = <strong class="text-rose-600 dark:text-rose-400">{{ evalFunc.y.toFixed(2) }}</strong></span>
      </div>
    </div>

  </div>
</template>