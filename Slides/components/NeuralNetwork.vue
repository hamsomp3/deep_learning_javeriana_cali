<script setup lang="ts">
import { ref, computed } from 'vue'

// Definición de la arquitectura de la red: 3 -> 5 -> 5 -> 5 -> 4
const layerConfigs = [
  { id: 0, title: 'Input layer', sub: 'Entrada (d=3)', count: 3, stroke: '#3b82f6', fill: '#eff6ff', darkFill: '#172554' },
  { id: 1, title: 'First hidden', sub: '1ª Oculta', count: 5, stroke: '#ef4444', fill: '#fef2f2', darkFill: '#450a0a' },
  { id: 2, title: 'Second hidden', sub: '2ª Oculta', count: 5, stroke: '#ef4444', fill: '#fef2f2', darkFill: '#450a0a' },
  { id: 3, title: 'Third hidden', sub: '3ª Oculta', count: 5, stroke: '#ef4444', fill: '#fef2f2', darkFill: '#450a0a' },
  { id: 4, title: 'Output layer', sub: 'Salida (k=4)', count: 4, stroke: '#10b981', fill: '#ecfdf5', darkFill: '#064e3b' },
]

const r = 13 // Radio de cada neurona
const activeLayer = ref<number | null>(null) // Para animación de forward pass
const hoveredNode = ref<string | null>(null) // Interacción al pasar el ratón

// Generar las posiciones (x, y) de cada neurona
const nodes = computed(() => {
  const result: Array<{ id: string; layer: number; index: number; x: number; y: number; stroke: string; fill: string; darkFill: string }> = []
  const xPositions = [70, 230, 390, 550, 710]
  const centerY = 145

  layerConfigs.forEach((cfg, lIdx) => {
    const x = xPositions[lIdx]
    const spacing = 42
    const totalHeight = (cfg.count - 1) * spacing
    const startY = centerY - totalHeight / 2

    for (let i = 0; i < cfg.count; i++) {
      result.push({
        id: `L${lIdx}_N${i}`,
        layer: lIdx,
        index: i,
        x,
        y: startY + i * spacing,
        stroke: cfg.stroke,
        fill: cfg.fill,
        darkFill: cfg.darkFill
      })
    }
  })
  return result
})

// Generar las conexiones totalmente conectadas entre capas adyacentes
const edges = computed(() => {
  const lines: Array<{ id: string; from: string; to: string; x1: number; y1: number; x2: number; y2: number; fromLayer: number }> = []

  for (let l = 0; l < layerConfigs.length - 1; l++) {
    const sourceNodes = nodes.value.filter(n => n.layer === l)
    const targetNodes = nodes.value.filter(n => n.layer === l + 1)

    sourceNodes.forEach(s => {
      targetNodes.forEach(t => {
        // Cálculo geométrico para que la flecha inicie y termine en el borde del círculo
        const dx = t.x - s.x
        const dy = t.y - s.y
        const dist = Math.hypot(dx, dy)
        const ux = dx / dist
        const uy = dy / dist

        lines.push({
          id: `${s.id}->${t.id}`,
          from: s.id,
          to: t.id,
          fromLayer: l,
          x1: s.x + ux * r,
          y1: s.y + uy * r,
          x2: t.x - ux * (r + 4), // Dejar 4px de margen para la cabeza de la flecha
          y2: t.y - uy * (r + 4)
        })
      })
    })
  }
  return lines
})

// Animación de Forward Pass
const isAnimating = ref(false)
const runForwardPass = async () => {
  if (isAnimating.value) return
  isAnimating.value = true
  for (let l = 0; l <= 4; l++) {
    activeLayer.value = l
    await new Promise(res => setTimeout(res, 450))
  }
  setTimeout(() => {
    activeLayer.value = null
    isAnimating.value = false
  }, 600)
}
</script>

<template>
  <div class="flex flex-col items-center w-full bg-white/70 dark:bg-zinc-900/70 p-3 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-sm select-none">
    
    <!-- Barra superior con control interactivo -->
    <div class="flex justify-between items-center w-full px-4 mb-1">
      <div class="text-xs text-slate-500 dark:text-zinc-400 font-mono">
        Total parámetros: <span class="text-indigo-600 dark:text-indigo-400 font-bold">85 conexiones</span> (15 + 25 + 25 + 20)
      </div>
      <button 
        @click="runForwardPass"
        :disabled="isAnimating"
        class="flex items-center gap-1.5 px-3 py-1 text-xs rounded-lg font-medium transition bg-indigo-600 hover:bg-indigo-500 text-white shadow disabled:opacity-50"
      >
        <span>⚡</span>
        <span>{{ isAnimating ? 'Propagando señal...' : 'Simular Forward Pass' }}</span>
      </button>
    </div>

    <!-- Gráfico Vectorial Completo -->
    <svg viewBox="0 0 780 270" class="w-full max-w-[760px] h-auto">
      <defs>
        <!-- Marcador estándar de flecha -->
        <marker id="nn-arrow" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="4" markerHeight="4" orient="auto">
          <path d="M 0 1.5 L 8 5 L 0 8.5 z" class="fill-slate-800 dark:fill-zinc-300" />
        </marker>
        <!-- Marcador para flecha activa/iluminada -->
        <marker id="nn-arrow-active" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="4.5" markerHeight="4.5" orient="auto">
          <path d="M 0 1.5 L 8 5 L 0 8.5 z" fill="#6366f1" />
        </marker>
      </defs>

      <!-- Títulos superiores de cada capa -->
      <g>
        <text 
          v-for="(cfg, idx) in layerConfigs" 
          :key="idx"
          :x="nodes.find(n => n.layer === idx)?.x" 
          y="22" 
          text-anchor="middle"
          class="font-serif text-[12px] font-semibold fill-slate-800 dark:fill-zinc-200"
        >
          {{ cfg.title }}
        </text>
      </g>

      <!-- Capa de Conexiones (Flechas) -->
      <g>
        <line 
          v-for="edge in edges" 
          :key="edge.id"
          :x1="edge.x1" :y1="edge.y1" 
          :x2="edge.x2" :y2="edge.y2"
          :stroke-width="activeLayer === edge.fromLayer ? 1.8 : 0.9"
          :class="[
            activeLayer === edge.fromLayer 
              ? 'stroke-indigo-500 transition-all duration-300' 
              : 'stroke-slate-800/80 dark:stroke-zinc-400/60'
          ]"
          :marker-end="activeLayer === edge.fromLayer ? 'url(#nn-arrow-active)' : 'url(#nn-arrow)'"
        />
      </g>

      <!-- Capa de Nodos (Neuronas) -->
      <g>
        <g 
          v-for="n in nodes" 
          :key="n.id" 
          class="cursor-pointer transition-transform duration-200"
          :class="{ 'scale-125 origin-center': activeLayer === n.layer }"
          @mouseenter="hoveredNode = n.id"
          @mouseleave="hoveredNode = null"
        >
          <!-- Círculo exterior (Neurona) -->
          <circle 
            :cx="n.x" 
            :cy="n.y" 
            :r="r" 
            :stroke="n.stroke"
            stroke-width="2" 
            :fill="activeLayer === n.layer ? n.stroke : 'white'"
            class="transition-all duration-300 dark:fill-zinc-900"
          />
        </g>
      </g>
    </svg>

  </div>
</template>