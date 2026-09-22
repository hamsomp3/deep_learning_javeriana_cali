<script setup lang="ts">
import { ref, computed } from 'vue'

// Permite alternar entre la Capa [2] (de tu imagen) y la Capa [1] (del texto de tu slide)
const layer = ref<'2' | '1'>('2')

const config = computed(() => {
  if (layer.value === '2') {
    return {
      sup: '[2]',
      inputs: ['1', 'h₁', 'h₂', 'h₃'],
      outLabel: 'ŷ',
      weights: ['w₁,₀', 'w₁,₁', 'w₁,₂', 'w₁,₃'],
      formulaSymbol: 'h'
    }
  } else {
    return {
      sup: '[1]',
      inputs: ['1', 'x₁', 'x₂', 'x₃'],
      outLabel: 'h₁',
      weights: ['w₁,₀', 'w₁,₁', 'w₁,₂', 'w₁,₃'],
      formulaSymbol: 'x'
    }
  }
})

// Coordenadas calculadas para que las cajas naranjas queden perfectamente alineadas
const nodesY = [28, 98, 168, 238]
const target = { x: 205, y: 133 }
</script>

<template>
  <div class="flex flex-col items-center bg-white/80 dark:bg-zinc-900/80 p-3 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-sm select-none">
    
    <!-- Selector de Capa para interactividad en la charla -->
    <div class="flex gap-2 mb-2">
      <button 
        @click="layer = '2'" 
        class="px-2.5 py-0.5 text-xs rounded-md font-medium transition"
        :class="layer === '2' ? 'bg-amber-500 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Capa [2]: h → ŷ (Imagen)
      </button>
      <button 
        @click="layer = '1'" 
        class="px-2.5 py-0.5 text-xs rounded-md font-medium transition"
        :class="layer === '1' ? 'bg-amber-500 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Capa [1]: x → h₁ (Slide)
      </button>
    </div>

    <!-- Área Gráfica: Diagrama + Ecuación -->
    <div class="flex items-center gap-2">
      
      <!-- Contenedor del Diagrama Vectorial -->
      <div class="relative w-[240px] h-[270px]">
        
        <!-- Líneas y flechas directas hacia la neurona de salida -->
        <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 240 270">
          <defs>
            <marker id="neuron-arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto">
              <path d="M 0 2 L 7 5 L 0 8 z" class="fill-[#1e3a8a] dark:fill-indigo-300" />
            </marker>
          </defs>

          <!-- Flecha 1 -> salida -->
          <line x1="58" y1="36" x2="188" y2="122" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#neuron-arrow)" />
          <!-- Flecha h1 -> salida -->
          <line x1="60" y1="102" x2="186" y2="128" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#neuron-arrow)" />
          <!-- Flecha h2 -> salida -->
          <line x1="60" y1="164" x2="186" y2="138" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#neuron-arrow)" />
          <!-- Flecha h3 -> salida -->
          <line x1="58" y1="230" x2="188" y2="144" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#neuron-arrow)" />
        </svg>

        <!-- Nodos de Entrada (Azul) -->
        <div 
          v-for="(label, i) in config.inputs" 
          :key="label"
          :style="{ top: `${nodesY[i] - 18}px` }"
          class="absolute left-[16px] w-9 h-9 rounded-full border-2 border-[#1e3a8a] bg-[#eff6ff] dark:bg-[#1e293b] text-[#1e3a8a] dark:text-blue-300 flex items-center justify-center font-serif text-base shadow-sm"
        >
          <span :class="{ 'italic': i > 0 }">{{ label }}</span>
        </div>

        <!-- Cajas Naranjas Punteadas con los Pesos (Dashed Badges) -->
        <!-- Peso 1 (bias) -->
        <div class="absolute left-[92px] top-[60px] px-1.5 py-0.5 rounded-lg border-2 border-dashed border-amber-500 bg-white/95 dark:bg-zinc-900/95 shadow-sm font-serif text-xs leading-none">
          <i>w</i><sub class="text-[9px] not-italic">1,0</sub><sup class="text-[9px] font-sans font-bold text-amber-600 dark:text-amber-400">{{ config.sup }}</sup>
        </div>

        <!-- Peso 2 -->
        <div class="absolute left-[92px] top-[98px] px-1.5 py-0.5 rounded-lg border-2 border-dashed border-amber-500 bg-white/95 dark:bg-zinc-900/95 shadow-sm font-serif text-xs leading-none">
          <i>w</i><sub class="text-[9px] not-italic">1,1</sub><sup class="text-[9px] font-sans font-bold text-amber-600 dark:text-amber-400">{{ config.sup }}</sup>
        </div>

        <!-- Peso 3 -->
        <div class="absolute left-[92px] top-[138px] px-1.5 py-0.5 rounded-lg border-2 border-dashed border-amber-500 bg-white/95 dark:bg-zinc-900/95 shadow-sm font-serif text-xs leading-none">
          <i>w</i><sub class="text-[9px] not-italic">1,2</sub><sup class="text-[9px] font-sans font-bold text-amber-600 dark:text-amber-400">{{ config.sup }}</sup>
        </div>

        <!-- Peso 4 -->
        <div class="absolute left-[92px] top-[178px] px-1.5 py-0.5 rounded-lg border-2 border-dashed border-amber-500 bg-white/95 dark:bg-zinc-900/95 shadow-sm font-serif text-xs leading-none">
          <i>w</i><sub class="text-[9px] not-italic">1,3</sub><sup class="text-[9px] font-sans font-bold text-amber-600 dark:text-amber-400">{{ config.sup }}</sup>
        </div>

        <!-- Neurona de Salida (Rojo/Coral) con su línea divisoria interna -->
        <div class="absolute left-[190px] top-[114px] w-10 h-10 rounded-full border-2 border-[#991b1b] bg-[#fee2e2] dark:bg-[#450a0a]/60 text-[#7f1d1d] dark:text-rose-200 flex items-center justify-center font-serif text-lg italic shadow-sm relative overflow-hidden">
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-[#991b1b]/40"></div>
          <span class="relative z-10">{{ config.outLabel }}</span>
        </div>

      </div>

      <!-- Fórmula Matemática tipográfica al lado del nodo -->
      <div class="font-serif text-sm tracking-tight text-slate-800 dark:text-zinc-100 pl-1">
        <span class="italic font-bold text-base">{{ config.outLabel }}</span> = 
        <span class="italic font-bold text-base">g</span>
        <span class="text-xl font-light scale-y-125 inline-block mx-0.5">(</span>
        <span>
          <i>w</i><sub class="text-[10px]">1,0</sub><sup class="text-[9px] font-sans font-bold text-amber-600 dark:text-amber-400">{{ config.sup }}</sup>
          + 
          <span class="inline-flex flex-col items-center mx-1 align-middle text-xs">
            <span class="text-[9px] -mb-1">3</span>
            <span class="text-base leading-none">∑</span>
            <span class="text-[9px] -mt-0.5">j=1</span>
          </span>
          <i>w</i><sub class="text-[10px]">1,j</sub><sup class="text-[9px] font-sans font-bold text-amber-600 dark:text-amber-400">{{ config.sup }}</sup>
          <i>{{ config.formulaSymbol }}</i><sub class="text-[10px]">j</sub>
        </span>
        <span class="text-xl font-light scale-y-125 inline-block mx-0.5">)</span>
      </div>

    </div>
  </div>
</template>