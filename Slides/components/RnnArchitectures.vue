<script setup lang="ts">
import { ref } from 'vue'

const selected = ref<'many_to_one' | 'one_to_many' | 'many_to_many_sync' | 'many_to_many_seq2seq'>('many_to_one')

const architectures = {
  many_to_one: {
    title: 'Many to One (Muchas entradas → Una salida)',
    useCase: 'Análisis de Sentimientos / Clasificación de Texto',
    example: '"La película fue increíblemente buena" ➔ ★★★★★ (Positivo)',
    inCount: 4,
    outIndices: [3]
  },
  one_to_many: {
    title: 'One to Many (Una entrada → Secuencia de salida)',
    useCase: 'Generación de Música / Subtitulado de Imágenes (Image Captioning)',
    example: 'Imagen de un gato ➔ "Un gato durmiendo en el sofá"',
    inCount: 1,
    outIndices: [0, 1, 2, 3]
  },
  many_to_many_sync: {
    title: 'Many to Many Sincronizado (Tx = Ty)',
    useCase: 'Etiquetado de Secuencias (POS Tagging) / Reconocimiento de Entidades (NER)',
    example: 'Cada palabra recibe una etiqueta gramatical en el mismo instante temporal',
    inCount: 4,
    outIndices: [0, 1, 2, 3]
  },
  many_to_many_seq2seq: {
    title: 'Many to Many Asíncrono (Seq2Seq / Encoder-Decoder)',
    useCase: 'Traducción Automática / Resumen de Texto (Tx ≠ Ty)',
    example: '"Good morning" (2 tokens) ➔ "Buenos días a todos" (4 tokens)',
    inCount: 3,
    outIndices: [3, 4]
  }
}
</script>

<template>
  <div class="flex flex-col items-center bg-white/80 dark:bg-zinc-900/90 p-4 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[460px]">

    <!-- Botones de Patrones de Arquitectura -->
    <div class="grid grid-cols-2 gap-1.5 w-full mb-3 text-xs">
      <button
        @click="selected = 'many_to_one'"
        class="py-1.5 px-2 rounded-lg font-medium transition text-left"
        :class="selected === 'many_to_one' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-100 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Many to One (Sentimiento)
      </button>
      <button
        @click="selected = 'one_to_many'"
        class="py-1.5 px-2 rounded-lg font-medium transition text-left"
        :class="selected === 'one_to_many' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-100 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        One to Many (Música)
      </button>
      <button
        @click="selected = 'many_to_many_sync'"
        class="py-1.5 px-2 rounded-lg font-medium transition text-left"
        :class="selected === 'many_to_many_sync' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-100 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Many to Many (NER / Tx=Ty)
      </button>
      <button
        @click="selected = 'many_to_many_seq2seq'"
        class="py-1.5 px-2 rounded-lg font-medium transition text-left"
        :class="selected === 'many_to_many_seq2seq' ? 'bg-indigo-600 text-white shadow' : 'bg-slate-100 dark:bg-zinc-800 text-slate-700 dark:text-zinc-300'"
      >
        Seq2Seq (Traducción)
      </button>
    </div>

    <!-- Visualizador Dinámico de Bloques (Inspirado en Karpathy) -->
    <div class="flex items-center justify-center gap-4 py-4 w-full h-[150px] bg-slate-50 dark:bg-zinc-950/50 rounded-xl border border-slate-200 dark:border-zinc-800/80">

      <div v-for="step in 4" :key="step" class="flex flex-col items-center gap-2">
        <!-- Salida Y (Rojo/Rosa) -->
        <div
          class="w-8 h-8 rounded-lg border-2 flex items-center justify-center text-xs font-serif italic transition-all duration-300"
          :class="architectures[selected].outIndices.includes(step - 1)
            ? 'border-rose-600 bg-rose-100 dark:bg-rose-950/80 text-rose-700 dark:text-rose-200 scale-100 shadow-md'
            : 'border-dashed border-slate-300 dark:border-zinc-700 opacity-20 scale-90'"
        >
          ŷ{{ step }}
        </div>

        <div class="text-slate-400 text-xs">↑</div>

        <!-- Estado Oculto H (Verde/Esmeralda) -->
        <div class="w-9 h-9 rounded-lg border-2 border-emerald-600 bg-emerald-100 dark:bg-emerald-950/80 text-emerald-800 dark:text-emerald-200 flex items-center justify-center text-xs font-serif font-bold shadow">
          h{{ step }}
        </div>

        <div class="text-slate-400 text-xs">↑</div>

        <!-- Entrada X (Azul) -->
        <div
          class="w-8 h-8 rounded-lg border-2 flex items-center justify-center text-xs font-serif italic transition-all duration-300"
          :class="(selected === 'one_to_many' ? step === 1 : step <= architectures[selected].inCount)
            ? 'border-blue-600 bg-blue-100 dark:bg-blue-950/80 text-blue-700 dark:text-blue-200 scale-100 shadow-md'
            : 'border-dashed border-slate-300 dark:border-zinc-700 opacity-20 scale-90'"
        >
          x{{ step }}
        </div>
      </div>

    </div>

    <!-- Descripción del Caso de Uso -->
    <div class="w-full mt-3 p-2 rounded-lg bg-indigo-50/70 dark:bg-indigo-950/30 border border-indigo-200 dark:border-indigo-900/50 text-xs">
      <div class="font-bold text-indigo-950 dark:text-indigo-200">{{ architectures[selected].title }}</div>
      <div class="text-slate-600 dark:text-zinc-300 text-[11px] mt-0.5">{{ architectures[selected].example }}</div>
    </div>

  </div>
</template>
