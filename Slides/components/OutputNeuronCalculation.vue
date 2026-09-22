<script setup lang="ts">
import { ref, computed } from 'vue'

// Modo: 'symbolic' (fórmulas y símbolos) | 'numeric' (valores numéricos reales)
const mode = ref<'symbolic' | 'numeric'>('symbolic')

// Función de activación seleccionada para el cálculo numérico
const actFn = ref<'sigmoid' | 'relu' | 'linear'>('sigmoid')

// Valores de ejemplo para la simulación numérica
const inputsNum = { bias: 1, h1: 0.6, h2: -0.4, h3: 0.8 }
const weightsNum = { w0: 0.2, w1: 0.5, w2: -0.3, w3: 0.4 }

// Cálculo de la combinación lineal: z = w0*1 + w1*h1 + w2*h2 + w3*h3
// z = 0.2 + (0.30) + (0.12) + (0.32) = 0.94
const zValue = computed(() => {
  const z = weightsNum.w0 * inputsNum.bias +
            weightsNum.w1 * inputsNum.h1 +
            weightsNum.w2 * inputsNum.h2 +
            weightsNum.w3 * inputsNum.h3
  return Number(z.toFixed(2))
})

// Cálculo de y_hat aplicando g(z)
const yHatValue = computed(() => {
  const z = zValue.value
  if (actFn.value === 'sigmoid') {
    return Number((1 / (1 + Math.exp(-z))).toFixed(2))
  } else if (actFn.value === 'relu') {
    return Number(Math.max(0, z).toFixed(2))
  } else {
    return z
  }
})

// Etiquetas dinámicas según el modo
const labels = computed(() => {
  if (mode.value === 'symbolic') {
    return {
      in: ['1', 'h₁', 'h₂', 'h₃'],
      w: ['w₁,₀', 'w₁,₁', 'w₁,₂', 'w₁,₃'],
      sup: '[2]',
      zText: 'z₁',
      gText: 'g(·)',
      yText: 'ŷ'
    }
  } else {
    return {
      in: ['1.0', `${inputsNum.h1}`, `${inputsNum.h2}`, `${inputsNum.h3}`],
      w: [`${weightsNum.w0}`, `${weightsNum.w1}`, `${weightsNum.w2}`, `${weightsNum.w3}`],
      sup: '',
      zText: `${zValue.value}`,
      gText: actFn.value.toUpperCase(),
      yText: `${yHatValue.value}`
    }
  }
})
</script>

<template>
  <div class="flex flex-col items-center bg-white/85 dark:bg-zinc-900/85 p-4 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-sm select-none">
    
    <!-- Barra de Control: Selector de Modo y Activación -->
    <div class="flex items-center justify-between w-full mb-2 px-1">
      <div class="flex gap-1.5">
        <button 
          @click="mode = 'symbolic'" 
          class="px-2.5 py-1 text-xs rounded-md font-medium transition"
          :class="mode === 'symbolic' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
        >
          Simbólico
        </button>
        <button 
          @click="mode = 'numeric'" 
          class="px-2.5 py-1 text-xs rounded-md font-medium transition"
          :class="mode === 'numeric' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-200 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
        >
          Cálculo Numérico
        </button>
      </div>

      <!-- Selector de activación en modo numérico -->
      <div v-if="mode === 'numeric'" class="flex items-center gap-1 text-[11px]">
        <span class="font-serif italic text-slate-500">g:</span>
        <button 
          @click="actFn = 'sigmoid'" 
          :class="actFn === 'sigmoid' ? 'text-indigo-600 font-bold underline' : 'text-slate-500'"
        >
          σ
        </button>
        <button 
          @click="actFn = 'relu'" 
          :class="actFn === 'relu' ? 'text-indigo-600 font-bold underline' : 'text-slate-500'"
        >
          ReLU
        </button>
      </div>
    </div>

    <!-- Lienzo del Diagrama -->
    <div class="relative w-[370px] h-[270px]">
      
      <!-- Flechas SVG vectoriales directas al sumador -->
      <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 370 270">
        <defs>
          <marker id="out-arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" class="fill-[#1e3a8a] dark:fill-indigo-300" />
          </marker>
          <marker id="final-arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto">
            <path d="M 0 2 L 7 5 L 0 8 z" class="fill-emerald-600 dark:fill-emerald-400" />
          </marker>
        </defs>

        <!-- Conexiones hacia la neurona de salida -->
        <line x1="56" y1="35" x2="168" y2="120" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#out-arrow)" />
        <line x1="58" y1="98" x2="166" y2="128" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#out-arrow)" />
        <line x1="58" y1="162" x2="166" y2="138" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#out-arrow)" />
        <line x1="56" y1="225" x2="168" y2="146" class="stroke-[#1e3a8a] dark:stroke-indigo-300" stroke-width="1.8" marker-end="url(#out-arrow)" />

        <!-- Flecha de salida hacia y_hat -->
        <line x1="248" y1="133" x2="295" y2="133" class="stroke-emerald-600 dark:stroke-emerald-400" stroke-width="2.5" marker-end="url(#final-arrow)" />
      </svg>

      <!-- Nodos de Entrada h_j y Sesgo -->
      <div 
        v-for="(val, idx) in labels.in" 
        :key="idx"
        :style="{ top: `${[16, 79, 143, 206][idx]}px` }"
        class="absolute left-[16px] w-9 h-9 rounded-full border-2 border-[#1e3a8a] bg-[#eff6ff] dark:bg-[#1e293b] text-[#1e3a8a] dark:text-blue-300 flex items-center justify-center font-serif text-sm shadow-sm"
      >
        <span :class="{ 'italic': mode === 'symbolic' && idx > 0 }">{{ val }}</span>
      </div>

      <!-- Cajas Naranjas Punteadas con los Pesos -->
      <div 
        v-for="(w, idx) in labels.w" 
        :key="idx"
        :style="{ top: `${[62, 97, 137, 175][idx]}px` }"
        class="absolute left-[88px] px-1.5 py-0.5 rounded-lg border-2 border-dashed border-amber-500 bg-white/95 dark:bg-zinc-900/95 shadow-sm font-serif text-[11px] leading-none text-slate-800 dark:text-zinc-100"
      >
        <span>{{ w }}</span>
        <sup v-if="labels.sup" class="text-[9px] font-sans font-bold text-amber-600 dark:text-amber-400">{{ labels.sup }}</sup>
      </div>

      <!-- NÚCLEO ANATÓMICO DE LA NEURONA: Sumador (∑) + Activación (g) -->
      <div class="absolute left-[170px] top-[95px] w-[76px] h-[76px] rounded-full border-2 border-rose-600 bg-rose-50 dark:bg-rose-950/40 shadow-lg flex overflow-hidden">
        
        <!-- Mitad izquierda: Suma Ponderada -->
        <div class="w-1/2 h-full flex flex-col items-center justify-center border-r border-rose-300 dark:border-rose-800/80 bg-rose-100/40 dark:bg-rose-900/20">
          <span class="font-serif font-bold text-base text-rose-900 dark:text-rose-200">∑</span>
          <span class="text-[9px] font-mono text-rose-700 dark:text-rose-300 font-semibold">{{ labels.zText }}</span>
        </div>

        <!-- Mitad derecha: Función de Activación -->
        <div class="w-1/2 h-full flex flex-col items-center justify-center">
          <span class="font-serif italic font-bold text-xs text-rose-900 dark:text-rose-200">{{ labels.gText }}</span>
          <span class="text-[8px] uppercase tracking-tighter text-rose-600 dark:text-rose-400">act</span>
        </div>
      </div>

      <!-- Nodo de Salida Final y_hat -->
      <div class="absolute left-[300px] top-[110px] w-11 h-11 rounded-full border-2 border-emerald-600 bg-emerald-50 dark:bg-emerald-950/50 text-emerald-800 dark:text-emerald-200 flex items-center justify-center font-serif text-base font-bold shadow-md">
        <span class="italic">{{ labels.yText }}</span>
      </div>

    </div>

    <!-- Leyenda didáctica en el pie del gráfico -->
    <div class="text-[11px] text-slate-500 dark:text-zinc-400 font-mono mt-1">
      <span v-if="mode === 'symbolic'">
        Pre-activación: <strong>z₁ = w₀ + ∑ wⱼ hⱼ</strong> &nbsp;→&nbsp; Salida: <strong>ŷ = g(z₁)</strong>
      </span>
      <span v-else>
        z = {{ zValue }} &nbsp;→&nbsp; ŷ = {{ actFn }}({{ zValue }}) = <strong>{{ yHatValue }}</strong>
      </span>
    </div>

  </div>
</template>