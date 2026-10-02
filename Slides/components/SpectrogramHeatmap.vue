<script setup lang="ts">
import { ref, computed } from 'vue'

const dbMode = ref(true)

// Dimensiones de la mini-espectrograma sintética (Tiempo x Frecuencia)
const T = 28
const F = 18
const CELL = 10

const gauss = (x: number, mu: number, sig: number) => Math.exp(-((x - mu) ** 2) / (2 * sig * sig))

// Magnitud normalizada en [0, 1]: formantes que se desplazan + armónicos + envolvente silábica
const magnitude = (t: number, f: number) => {
  const tn = t / (T - 1)
  const fn = f / (F - 1)
  let v = 0
  v += 1.0 * gauss(fn, 0.2 + 0.07 * Math.sin(tn * Math.PI * 2), 0.055)
  v += 0.85 * gauss(fn, 0.48 + 0.12 * Math.sin(tn * Math.PI * 3 + 0.8), 0.07)
  v += 0.45 * gauss(fn, 0.76 + 0.05 * Math.sin(tn * Math.PI * 4), 0.05)
  v += 0.25 * Math.exp(-fn * 5)
  const env = 0.3 + 0.7 * Math.abs(Math.sin(tn * Math.PI * 5))
  v *= env
  v += 0.04 * (0.5 + 0.5 * Math.sin((t * 7 + f * 13) * 0.7))
  return Math.min(1, v)
}

// Escala dB: 20·log10(mag) normalizada con un piso de -40 dB
const toDb = (mag: number) => {
  const db = 20 * Math.log10(Math.max(mag, 1e-4))
  return Math.min(1, Math.max(0, (db + 40) / 40))
}

const stops: Array<[number, [number, number, number]]> = [
  [0.0, [13, 27, 42]],
  [0.33, [59, 76, 202]],
  [0.66, [0, 194, 209]],
  [1.0, [249, 224, 75]],
]

const colorFor = (mag: number) => {
  const v = dbMode.value ? toDb(mag) : mag
  for (let i = 0; i < stops.length - 1; i++) {
    const [a, ca] = stops[i]
    const [b, cb] = stops[i + 1]
    if (v >= a && v <= b) {
      const k = (v - a) / (b - a)
      const r = Math.round(ca[0] + (cb[0] - ca[0]) * k)
      const g = Math.round(ca[1] + (cb[1] - ca[1]) * k)
      const bl = Math.round(ca[2] + (cb[2] - ca[2]) * k)
      return `rgb(${r},${g},${bl})`
    }
  }
  return 'rgb(249,224,75)'
}

const cells = computed(() => {
  const out: Array<{ t: number; f: number; color: string }> = []
  for (let f = 0; f < F; f++) {
    for (let t = 0; t < T; t++) {
      out.push({ t, f, color: colorFor(magnitude(t, f)) })
    }
  }
  return out
})
</script>

<template>
  <div class="flex flex-col items-center bg-white/90 dark:bg-zinc-900/90 p-3.5 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[420px]">

    <div class="flex items-center justify-between w-full mb-2 gap-2">
      <div class="text-[12px] font-bold text-slate-800 dark:text-zinc-100">Espectrograma = Imagen 2D</div>
      <div class="flex gap-1">
        <button @click="dbMode = false"
          class="px-2 py-1 text-[10px] rounded-lg font-bold transition"
          :class="!dbMode ? 'bg-indigo-600 text-white shadow-sm' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300'">
          Lineal
        </button>
        <button @click="dbMode = true"
          class="px-2 py-1 text-[10px] rounded-lg font-bold transition"
          :class="dbMode ? 'bg-indigo-600 text-white shadow-sm' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300'">
          dB (log)
        </button>
      </div>
    </div>

    <!-- Lienzo del espectrograma con ejes -->
    <div class="relative w-full flex items-stretch gap-1">
      <!-- Etiqueta eje frecuencia -->
      <div class="flex items-center">
        <span class="text-[9px] font-bold text-slate-500 -rotate-90 whitespace-nowrap">Frecuencia (Hz)</span>
      </div>

      <div class="flex-1 flex flex-col">
        <svg :viewBox="`0 0 ${T * CELL} ${F * CELL}`" class="w-full rounded-lg border border-slate-300 dark:border-zinc-700" preserveAspectRatio="none">
          <rect v-for="(c, i) in cells" :key="i" :x="c.t * CELL" :y="(F - 1 - c.f) * CELL" :width="CELL" :height="CELL" :fill="c.color" />
        </svg>
        <!-- Eje tiempo -->
        <div class="flex justify-between text-[9px] font-mono text-slate-500 mt-0.5 px-0.5">
          <span>t = 0 s</span>
          <span class="font-bold text-slate-400">Tiempo →</span>
          <span>t = 1 s</span>
        </div>
      </div>
    </div>

    <!-- Escala de color -->
    <div class="w-full mt-2">
      <div class="flex items-center gap-2">
        <span class="text-[9px] font-bold text-slate-500">-40 dB</span>
        <div class="flex-1 h-2 rounded-full" style="background: linear-gradient(to right, rgb(13,27,42), rgb(59,76,202), rgb(0,194,209), rgb(249,224,75))"></div>
        <span class="text-[9px] font-bold text-slate-500">0 dB</span>
      </div>
    </div>

    <!-- Explicación -->
    <div class="w-full mt-2 p-2 rounded-xl bg-slate-100 dark:bg-zinc-800/80 border border-slate-200 dark:border-zinc-700 text-[11px] text-slate-600 dark:text-zinc-300 leading-snug">
      <span v-if="dbMode">
        La compresión <strong>logarítmica (dB)</strong> revela los formantes débiles: es la representación estándar de entrada a la red.
      </span>
      <span v-else>
        En escala <strong>lineal</strong> las frecuencias graves dominan y los detalles de alta frecuencia se pierden.
      </span>
      <span class="block mt-1 font-mono text-indigo-600 dark:text-indigo-400">
        Tensor: <strong>(124, 129, 1)</strong> → Alto × Ancho × Canal
      </span>
    </div>

  </div>
</template>
