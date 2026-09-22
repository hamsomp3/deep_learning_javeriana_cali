<script setup lang="ts">
import { ref, computed } from 'vue'

// Modo: 'theory' (idéntico a tu imagen) | 'simulation' (interactivo en vivo)
const mode = ref<'theory' | 'simulation'>('theory')

// Parámetro w1 interactivo (-1 a 1 normalizado, donde 0 es el mínimo óptimo w1*)
const u = ref(0.75) // Comienza hacia la derecha

// Geometría del SVG (340 x 300)
// Origen de los ejes en (45, 255)
// Vértice mínimo de la parábola en (180, 215)
const xMin = 180
const yMin = 215

// Coordenadas del punto sobre la parábola según u:
// x = 180 + u * 110
// y = 215 - 165 * u^2  (en SVG el eje Y crece hacia abajo)
const currentX = computed(() => xMin + u.value * 110)
const currentY = computed(() => yMin - 165 * Math.pow(u.value, 2))

// Recta tangente (derivada / pendiente del gradiente)
const tangent = computed(() => {
  const x = currentX.value
  const y = currentY.value
  // Pendiente en coordenadas SVG: dy/dx = -2 * (165 / 110) * u = -3.0 * u
  const slope = -3.0 * u.value
  const dx = 35
  const dy = slope * dx
  return {
    x1: x - dx,
    y1: y - dy,
    x2: x + dx,
    y2: y + dy
  }
})

// Función para dar un "paso de gradiente" en vivo hacia el mínimo
const takeGradientStep = () => {
  const learningRate = 0.35
  u.value = Number((u.value - learningRate * u.value).toFixed(3))
}

const resetPosition = () => {
  u.value = 0.8
}
</script>

<template>
  <div class="flex flex-col items-center bg-white/80 dark:bg-zinc-900/80 p-4 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-sm select-none">
    
    <!-- Barra superior de modos -->
    <div class="flex gap-2 mb-1">
      <button 
        @click="mode = 'theory'" 
        class="px-3 py-1 text-xs rounded-lg font-medium transition"
        :class="mode === 'theory' ? 'bg-sky-600 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Vista Teórica
      </button>
      <button 
        @click="mode = 'simulation'" 
        class="px-3 py-1 text-xs rounded-lg font-medium transition"
        :class="mode === 'simulation' ? 'bg-sky-600 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Simulador de Gradiente
      </button>
    </div>

    <!-- Lienzo Vectorial -->
    <div class="relative w-[340px] h-[300px]">
      
      <!-- Etiqueta superior L(w1) con caja celeste (estilo de tu imagen) -->
      <div class="absolute left-[16px] top-[14px] px-2 py-0.5 bg-sky-100 dark:bg-sky-950/80 border border-sky-300 dark:border-sky-700 rounded text-sky-900 dark:text-sky-200 text-sm font-serif font-medium shadow-sm">
        <span class="italic font-bold">ℒ</span>(<i>w</i><sub class="text-[10px] not-italic">1</sub>)
      </div>

      <svg viewBox="0 0 340 300" class="w-full h-full pointer-events-none">
        <defs>
          <!-- Flecha de los ejes cartesianos -->
          <marker id="axis-arrow-cost" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
            <path d="M 0 2 L 8 5 L 0 8 z" class="fill-slate-800 dark:fill-slate-100" />
          </marker>
        </defs>

        <!-- Eje Vertical L(w1) -->
        <line x1="45" y1="255" x2="45" y2="45" class="stroke-slate-800 dark:stroke-slate-100" stroke-width="1.8" marker-end="url(#axis-arrow-cost)" />

        <!-- Eje Horizontal w1 -->
        <line x1="45" y1="255" x2="310" y2="255" class="stroke-slate-800 dark:stroke-slate-100" stroke-width="1.8" marker-end="url(#axis-arrow-cost)" />

        <!-- Parábola convexa de la función de costo (curva Bézier matemática suave) -->
        <path d="M 70 50 Q 180 380 290 50" fill="none" class="stroke-slate-300 dark:stroke-zinc-600" stroke-width="2.5" stroke-linecap="round" />

        <!-- Línea vertical punteada al mínimo óptimo w1* -->
        <line x1="180" y1="215" x2="180" y2="255" class="stroke-slate-500 dark:stroke-zinc-400" stroke-width="1.5" stroke-dasharray="4 4" />

        <!-- Elementos del modo Simulador -->
        <template v-if="mode === 'simulation'">
          <!-- Línea tangente (pendiente del gradiente) -->
          <line 
            :x1="tangent.x1" :y1="tangent.y1" 
            :x2="tangent.x2" :y2="tangent.y2" 
            stroke="#f43f5e" 
            stroke-width="2" 
            stroke-linecap="round"
          />
          <!-- Punto actual sobre la curva de pérdida -->
          <circle 
            :cx="currentX" 
            :cy="currentY" 
            r="6" 
            class="fill-rose-500 stroke-white dark:stroke-zinc-900" 
            stroke-width="2" 
          />
        </template>
      </svg>

      <!-- Etiqueta del mínimo w1* debajo del eje -->
      <div class="absolute left-[180px] -translate-x-1/2 top-[260px] font-serif text-slate-800 dark:text-slate-100 text-sm">
        <i>w</i><sub class="text-[10px] not-italic">1</sub><sup class="text-[10px] font-bold -top-1">*</sup>
      </div>

      <!-- Etiqueta del eje horizontal w1 al final de la flecha -->
      <div class="absolute left-[315px] top-[244px] font-serif text-slate-800 dark:text-slate-100 text-sm italic">
        w<sub class="text-[10px] not-italic">1</sub>
      </div>
    </div>

    <!-- Controles interactivos para jugar en plena presentación -->
    <div v-if="mode === 'simulation'" class="w-full mt-2 pt-2 border-t border-slate-200 dark:border-zinc-800 flex flex-col gap-2 text-xs">
      <div class="flex items-center justify-between gap-2">
        <span class="font-serif italic text-slate-600 dark:text-zinc-400">Deslizar valor de w₁:</span>
        <input type="range" min="-0.95" max="0.95" step="0.01" v-model.number="u" class="w-32 accent-rose-500" />
      </div>
      <div class="flex justify-end gap-2">
        <button @click="resetPosition" class="px-2 py-0.5 text-[11px] rounded bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300">
          Reiniciar
        </button>
        <button @click="takeGradientStep" class="px-2.5 py-0.5 text-[11px] rounded bg-rose-600 text-white font-medium hover:bg-rose-500 transition">
          Paso de gradiente →
        </button>
      </div>
    </div>

  </div>
</template>