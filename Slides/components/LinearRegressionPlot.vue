<script setup lang="ts">
import { ref, computed } from 'vue'

// Puntos de datos (reproduce la distribución de tu imagen)
const points = [
  [-4.2, -4.5], [-3.8, -4.1], [-3.5, -4.0], [-3.0, -3.1], [-2.6, -3.5], 
  [-2.3, -2.2], [-1.8, -2.7], [-1.4, -1.8], [-1.0, -1.9], [-0.6, -1.0], 
  [-0.3, -0.7], [0.0, 0.2], [0.4, -0.3], [0.8, 0.4], [1.2, 0.1], 
  [1.5, 1.8], [1.9, 1.4], [2.2, 2.4], [2.6, 2.0], [2.9, 1.9], 
  [3.3, 3.0], [3.6, 3.4], [4.0, 3.6]
]

// Modo: 'presets' (muestra las dos líneas de tu imagen) o 'interactive' (sliders libres)
const mode = ref<'presets' | 'interactive'>('presets')

// Parámetros interactivos para jugar en vivo
const w0 = ref(-1.0)
const w1 = ref(2.0)

// Conversión de coordenadas matemáticas (-5 a 5) a píxeles SVG (0 a 340)
const toSvgX = (x: number) => 170 + x * 30
const toSvgY = (y: number) => 170 - y * 30

// Cálculo de extremos de una recta y = w0 + w1 * x
const getLineCoords = (b: number, m: number) => {
  const xA = -5.5
  const yA = b + m * xA
  const xB = 5.5
  const yB = b + m * xB
  return {
    x1: toSvgX(xA),
    y1: toSvgY(yA),
    x2: toSvgX(xB),
    y2: toSvgY(yB)
  }
}

const interactiveLine = computed(() => getLineCoords(w0.value, w1.value))
const linePreset1 = getLineCoords(1.0, -0.5) // Recta gris de la imagen
const linePreset2 = getLineCoords(-1.0, 2.0) // Recta roja de la imagen
</script>

<template>
  <div class="flex flex-col items-center bg-white/70 dark:bg-zinc-900/70 p-4 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-lg backdrop-blur-sm select-none">
    
    <!-- Selector de modo -->
    <div class="flex gap-2 mb-2">
      <button 
        @click="mode = 'presets'" 
        class="px-3 py-1 text-xs rounded-lg font-medium transition"
        :class="mode === 'presets' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Vista Original
      </button>
      <button 
        @click="mode = 'interactive'" 
        class="px-3 py-1 text-xs rounded-lg font-medium transition"
        :class="mode === 'interactive' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Control en Vivo
      </button>
    </div>

    <!-- Gráfico Vectorial SVG -->
    <svg viewBox="0 0 340 340" class="w-[280px] h-[280px]">
      <defs>
        <!-- Flechas para los ejes cartesianos -->
        <marker id="axis-arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
          <path d="M 0 2 L 8 5 L 0 8 z" class="fill-slate-800 dark:fill-slate-100" />
        </marker>
        <!-- Máscara para que las líneas no se salgan del plano -->
        <clipPath id="plot-bounds">
          <rect x="15" y="15" width="310" height="310" />
        </clipPath>
      </defs>

      <!-- Ejes X e Y -->
      <line x1="15" y1="170" x2="325" y2="170" class="stroke-slate-800 dark:stroke-slate-100" stroke-width="2" marker-end="url(#axis-arrow)" />
      <line x1="170" y1="325" x2="170" y2="15" class="stroke-slate-800 dark:stroke-slate-100" stroke-width="2" marker-end="url(#axis-arrow)" />
      <text x="335" y="174" class="font-serif italic font-bold fill-slate-800 dark:fill-slate-100 text-sm">x</text>
      <text x="170" y="10" class="font-serif italic font-bold fill-slate-800 dark:fill-slate-100 text-sm" text-anchor="middle">y</text>

      <!-- Rectas bajo clipPath -->
      <g clip-path="url(#plot-bounds)">
        
        <!-- Modo 1: Exacto como en tu imagen -->
        <template v-if="mode === 'presets'">
          <!-- Recta 1 (Gris: w0=1, w1=-0.5) -->
          <line :x1="linePreset1.x1" :y1="linePreset1.y1" :x2="linePreset1.x2" :y2="linePreset1.y2" stroke="#94a3b8" stroke-width="1.8" />
          <text x="120" y="145" class="fill-slate-400 font-serif italic text-[11px]" transform="rotate(15 120 145)" text-anchor="middle">
            w₀ = 1,  w₁ = -0.5
          </text>

          <!-- Recta 2 (Roja: w0=-1, w1=2) -->
          <line :x1="linePreset2.x1" :y1="linePreset2.y1" :x2="linePreset2.x2" :y2="linePreset2.y2" stroke="#ef4444" stroke-width="2.2" />
          <text x="195" y="245" class="fill-red-500 font-serif italic text-[11px]" transform="rotate(-63 195 245)" text-anchor="middle">
            w₀ = -1,  w₁ = 2
          </text>
        </template>

        <!-- Modo 2: Recta Dinámica con Sliders -->
        <template v-else>
          <line :x1="interactiveLine.x1" :y1="interactiveLine.y1" :x2="interactiveLine.x2" :y2="interactiveLine.y2" stroke="#ec4899" stroke-width="2.5" />
        </template>

        <!-- Puntos Azules -->
        <circle 
          v-for="(p, i) in points" 
          :key="i"
          :cx="toSvgX(p[0])" 
          :cy="toSvgY(p[1])" 
          r="4.5" 
          class="fill-blue-600 stroke-blue-900 dark:stroke-white/30" 
          stroke-width="1"
        />
      </g>
    </svg>

    <!-- Sliders interactivos (solo se muestran al activar el modo control) -->
    <div v-if="mode === 'interactive'" class="w-full mt-2 space-y-2 text-xs">
      <div class="flex items-center justify-between gap-2">
        <span class="font-serif italic">w₀ (Intercepto): <strong>{{ w0.toFixed(1) }}</strong></span>
        <input type="range" min="-4" max="4" step="0.1" v-model.number="w0" class="w-28 accent-pink-500" />
      </div>
      <div class="flex items-center justify-between gap-2">
        <span class="font-serif italic">w₁ (Pendiente): <strong>{{ w1.toFixed(1) }}</strong></span>
        <input type="range" min="-3" max="3" step="0.1" v-model.number="w1" class="w-28 accent-pink-500" />
      </div>
    </div>
  </div>
</template>