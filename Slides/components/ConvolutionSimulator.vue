<script setup lang="ts">
import { ref, computed } from 'vue'

// Imagen de entrada 5x5 simple (un borde vertical en el medio)
const inputMatrix = [
  [10, 10, 10, 200, 200],
  [10, 10, 10, 200, 200],
  [10, 10, 10, 200, 200],
  [10, 10, 10, 200, 200],
  [10, 10, 10, 200, 200]
]

// Tipos de kernels clásicos
const kernels = {
  sobelVertical: {
    name: 'Sobel Vertical (Detecta bordes verticales)',
    matrix: [
      [-1, 0, 1],
      [-2, 0, 2],
      [-1, 0, 1]
    ]
  },
  edgeDetect: {
    name: 'Laplaciano (Detección de bordes omnidireccional)',
    matrix: [
      [ 0,  1,  0],
      [ 1, -4,  1],
      [ 0,  1,  0]
    ]
  },
  identity: {
    name: 'Identidad / Filtro Neutro',
    matrix: [
      [0, 0, 0],
      [0, 1, 0],
      [0, 0, 0]
    ]
  }
}

const selectedKernelKey = ref<keyof typeof kernels>('sobelVertical')

// Posición actual del kernel (fila r, columna c en rango 0..2)
const posR = ref(1)
const posC = ref(1)

const currentKernel = computed(() => kernels[selectedKernelKey.value].matrix)

// Cálculo de la matriz de salida (3x3 con stride=1 y padding valid)
const outputMatrix = computed(() => {
  const k = currentKernel.value
  const out: number[][] = []
  for (let r = 0; r <= 2; r++) {
    const row: number[] = []
    for (let c = 0; c <= 2; c++) {
      let sum = 0
      for (let kr = 0; kr < 3; kr++) {
        for (let kc = 0; kc < 3; kc++) {
          sum += inputMatrix[r + kr][c + kc] * k[kr][kc]
        }
      }
      row.push(sum)
    }
    out.push(row)
  }
  return out
})

// Cálculo puntual en la posición seleccionada
const currentCalculation = computed(() => {
  const k = currentKernel.value
  let sum = 0
  const terms: string[] = []
  for (let kr = 0; kr < 3; kr++) {
    for (let kc = 0; kc < 3; kc++) {
      const val = inputMatrix[posR.value + kr][posC.value + kc]
      const weight = k[kr][kc]
      sum += val * weight
      if (weight !== 0) {
        terms.push(`(${val} × ${weight})`)
      }
    }
  }
  return {
    sum,
    formulaPreview: terms.slice(0, 4).join(' + ') + ' + ... = ' + sum
  }
})
</script>

<template>
  <div class="flex flex-col items-center bg-white/90 dark:bg-zinc-900/90 p-3 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[430px]">
    <div class="flex gap-1 justify-center mb-2 w-full">
      <button
        v-for="(item, key) in kernels"
        :key="key"
        @click="selectedKernelKey = key"
        class="px-2 py-0.5 text-[10px] rounded-md font-medium transition"
        :class="selectedKernelKey === key ? 'bg-indigo-600 text-white shadow-sm font-bold' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300 hover:bg-slate-200'"
      >
        {{ key === 'sobelVertical' ? 'Sobel Vertical' : key === 'edgeDetect' ? 'Laplaciano' : 'Identidad' }}
      </button>
    </div>
    <div class="grid grid-cols-11 gap-1 items-center justify-center my-1 w-full text-center">
      <div class="col-span-5 flex flex-col items-center">
        <div class="text-[10px] font-bold text-slate-500 mb-1">Entrada X (5×5)</div>
        <div class="grid grid-cols-5 gap-0.5 p-1 bg-slate-100 dark:bg-zinc-800 rounded-lg border border-slate-200 dark:border-zinc-700">
          <template v-for="(row, r) in inputMatrix" :key="r">
            <div
              v-for="(val, c) in row"
              :key="c"
              class="w-6 h-6 flex items-center justify-center text-[9px] font-mono font-bold rounded transition-all duration-150"
              :class="[
                r >= posR && r < posR + 3 && c >= posC && c < posC + 3
                  ? 'bg-indigo-500 text-white shadow-sm ring-1 ring-indigo-300 scale-105'
                  : val > 100
                    ? 'bg-amber-100 dark:bg-amber-950/60 text-amber-900 dark:text-amber-200'
                    : 'bg-white dark:bg-zinc-900 text-slate-600 dark:text-zinc-400'
              ]"
            >
              {{ val }}
            </div>
          </template>
        </div>
      </div>
      <div class="col-span-1 flex flex-col items-center justify-center font-bold text-indigo-600 dark:text-indigo-400 text-lg">
        ∗
      </div>
      <div class="col-span-2 flex flex-col items-center">
        <div class="text-[10px] font-bold text-indigo-600 dark:text-indigo-400 mb-1">Filtro (3×3)</div>
        <div class="grid grid-cols-3 gap-0.5 p-1 bg-indigo-50 dark:bg-indigo-950/60 rounded-lg border border-indigo-200 dark:border-indigo-800">
          <template v-for="(row, r) in currentKernel" :key="r">
            <div
              v-for="(w, c) in row"
              :key="c"
              class="w-5 h-5 flex items-center justify-center text-[9px] font-mono font-bold rounded bg-white dark:bg-zinc-900 text-indigo-900 dark:text-indigo-200 shadow-sm"
            >
              {{ w }}
            </div>
          </template>
        </div>
      </div>
      <div class="col-span-1 flex flex-col items-center justify-center font-bold text-slate-400 text-sm">
        =
      </div>
      <div class="col-span-2 flex flex-col items-center">
        <div class="text-[10px] font-bold text-rose-600 dark:text-rose-400 mb-1">Salida (3×3)</div>
        <div class="grid grid-cols-3 gap-0.5 p-1 bg-rose-50 dark:bg-rose-950/60 rounded-lg border border-rose-200 dark:border-rose-800">
          <template v-for="(row, r) in outputMatrix" :key="r">
            <button
              v-for="(outVal, c) in row"
              :key="c"
              @click="posR = r; posC = c"
              class="w-5 h-5 flex items-center justify-center text-[8px] font-mono font-bold rounded transition-all cursor-pointer"
              :class="r === posR && c === posC
                ? 'bg-rose-600 text-white shadow-sm ring-2 ring-rose-400 scale-110'
                : Math.abs(outVal) > 200
                  ? 'bg-rose-200 dark:bg-rose-900 text-rose-950 dark:text-rose-100 font-black'
                  : 'bg-white dark:bg-zinc-900 text-slate-600 dark:text-zinc-400 hover:bg-rose-100'"
            >
              {{ outVal }}
            </button>
          </template>
        </div>
      </div>
    </div>
    <div class="flex items-center justify-between w-full mt-2 px-2 text-[10px] text-slate-500 font-mono">
      <span>Posición Kernel (r, c): <strong>({{ posR }}, {{ posC }})</strong></span>
      <div class="flex gap-1">
        <button @click="posC = Math.max(0, posC - 1)" class="px-1.5 py-0.5 rounded bg-slate-100 dark:bg-zinc-800 hover:bg-slate-200">◀</button>
        <button @click="posC = Math.min(2, posC + 1)" class="px-1.5 py-0.5 rounded bg-slate-100 dark:bg-zinc-800 hover:bg-slate-200">▶</button>
        <button @click="posR = Math.max(0, posR - 1)" class="px-1.5 py-0.5 rounded bg-slate-100 dark:bg-zinc-800 hover:bg-slate-200">▲</button>
        <button @click="posR = Math.min(2, posR + 1)" class="px-1.5 py-0.5 rounded bg-slate-100 dark:bg-zinc-800 hover:bg-slate-200">▼</button>
      </div>
    </div>
    <div class="w-full mt-1.5 p-2 rounded-xl bg-slate-50 dark:bg-zinc-800/80 border border-slate-200 dark:border-zinc-700 text-[10px] leading-tight text-slate-700 dark:text-zinc-200">
      <div class="font-bold text-indigo-700 dark:text-indigo-300 mb-0.5">{{ kernels[selectedKernelKey].name }}</div>
      <div class="font-mono text-slate-600 dark:text-zinc-300 truncate">
        Σ (X_local ⊙ K) = {{ currentCalculation.formulaPreview }}
      </div>
    </div>
  </div>
</template>
