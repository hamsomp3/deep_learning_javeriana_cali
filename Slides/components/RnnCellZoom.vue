<script setup lang="ts">
import { ref, computed } from 'vue'
import katex from 'katex'

type ViewMode = 'compact' | 'detailed'
const mode = ref<ViewMode>('compact')

// Renderizado matemático KaTeX nativo
const m = (expr: string) => {
  try {
    return katex.renderToString(expr, { throwOnError: false })
  } catch {
    return expr
  }
}

const explanation = computed(() => {
  if (mode.value === 'compact') {
    return `En el paso 2 coinciden 3 matrices de pesos: ${m('W^{(h,x)}')} (entrada), ${m('W^{(h,h)}')} (memoria) y ${m('W^{(y,h)}')} (salida).`
  } else {
    return `Cada neurona ${m('h_{2,m}')} combina todas las neuronas previas ${m('h_{1,k}')} más todos los atributos ${m('x_{2,p}')}.`
  }
})
</script>

<template>
  <div class="flex flex-col items-center bg-white/90 dark:bg-zinc-900/90 p-3 rounded-2xl border border-slate-200 dark:border-zinc-800 shadow-xl backdrop-blur-md select-none w-full max-w-[430px]">
    
    <!-- Selector de Modo de Vista -->
    <div class="flex gap-1.5 justify-center mb-2 w-full">
      <button 
        @click="mode = 'compact'"
        class="px-2.5 py-1 text-xs rounded-md font-medium transition"
        :class="mode === 'compact' ? 'bg-indigo-600 text-white shadow-sm font-bold' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300 hover:bg-slate-200'"
      >
        1. Vista Celda (Paso t=2)
      </button>
      <button 
        @click="mode = 'detailed'"
        class="px-2.5 py-1 text-xs rounded-md font-medium transition"
        :class="mode === 'detailed' ? 'bg-indigo-600 text-white shadow-sm font-bold' : 'bg-slate-100 dark:bg-zinc-800 text-slate-600 dark:text-zinc-300 hover:bg-slate-200'"
      >
        2. Zoom Neuronal (Fully Connected)
      </button>
    </div>

    <!-- LIENZO DE DIBUJO (340px x 270px) -->
    <div class="relative select-none" style="width: 340px; height: 270px;">

      <!-- ========================================== -->
      <!-- MODO 1: VISTA COMPACTA (PASO t=2)         -->
      <!-- ========================================== -->
      <template v-if="mode === 'compact'">
        <!-- Flechas vectoriales -->
        <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 340 270">
          <defs>
            <marker id="zoom-arr-green" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
              <path d="M 0 2 L 7 5 L 0 8 z" class="fill-emerald-600 dark:fill-emerald-400" />
            </marker>
            <marker id="zoom-arr-blue" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
              <path d="M 0 2 L 7 5 L 0 8 z" class="fill-indigo-600 dark:fill-indigo-400" />
            </marker>
            <marker id="zoom-arr-rose" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="5" markerHeight="5" orient="auto">
              <path d="M 0 2 L 7 5 L 0 8 z" class="fill-rose-600 dark:fill-rose-400" />
            </marker>
          </defs>

          <!-- h1 -> h2 (Desde arriba en verde) -->
          <line x1="162" y1="48" x2="162" y2="128" stroke="#16a34a" stroke-width="1.8" marker-end="url(#zoom-arr-green)" />
          
          <!-- x2 -> h2 (Horizontal en azul/lila) -->
          <line x1="66" y1="150" x2="126" y2="150" stroke="#4f46e5" stroke-width="2" marker-end="url(#zoom-arr-blue)" />
          
          <!-- h2 -> y_hat2 (Horizontal en rosa/rojo) -->
          <line x1="202" y1="150" x2="260" y2="150" stroke="#e11d48" stroke-width="2" marker-end="url(#zoom-arr-rose)" />

          <!-- Llave decorativa inferior (corchete de paso t=2) -->
          <path d="M 30 205 C 30 215, 162 215, 162 225 C 162 215, 290 215, 290 205" fill="none" stroke="#94a3b8" stroke-width="1.5" />
        </svg>

        <!-- Nodo h1 superior -->
        <div class="absolute text-center text-xs font-bold text-emerald-800 dark:text-emerald-200" style="left: 137px; top: 22px; width: 50px;" v-html="m('h_1')"></div>
        <div class="absolute text-[11px] font-bold text-emerald-700 dark:text-emerald-400" style="left: 172px; top: 72px;" v-html="m('W^{(h,h)}')"></div>

        <!-- Nodo x2 (Verde) -->
        <div class="absolute rounded-full border-2 border-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 text-emerald-950 dark:text-emerald-100 flex items-center justify-center text-xs font-bold shadow-md" style="left: 24px; top: 129px; width: 42px; height: 42px;" v-html="m('x_2')"></div>
        <div class="absolute text-[11px] font-bold text-indigo-700 dark:text-indigo-400" style="left: 68px; top: 160px;" v-html="m('W^{(h,x)}')"></div>

        <!-- Celda h2 (Rectángulo lila con división interna de activación) -->
        <div class="absolute rounded-lg border-2 border-indigo-600 bg-indigo-100 dark:bg-indigo-950/80 text-indigo-950 dark:text-indigo-100 flex items-center justify-center text-sm font-bold shadow-lg overflow-hidden" style="left: 128px; top: 130px; width: 72px; height: 40px;">
          <div class="absolute inset-0 border-t border-indigo-400 dark:border-indigo-600 transform rotate-12 origin-top-left pointer-events-none opacity-50"></div>
          <span class="relative z-10" v-html="m('h_2')"></span>
        </div>

        <!-- Salida y_hat2 (Rojo/Rosa) -->
        <div class="absolute text-[11px] font-bold text-rose-700 dark:text-rose-400" style="left: 205px; top: 160px;" v-html="m('W^{(y,h)}')"></div>
        <div class="absolute rounded-full border-2 border-rose-600 bg-rose-100 dark:bg-rose-950/60 text-rose-950 dark:text-rose-100 flex items-center justify-center text-xs font-bold shadow-md overflow-hidden" style="left: 262px; top: 129px; width: 42px; height: 42px;">
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-rose-400 rotate-45"></div>
          <span class="relative z-10" v-html="m('\\hat{y}_2')"></span>
        </div>
      </template>

      <!-- ========================================== -->
      <!-- MODO 2: ZOOM NEURONAL (FULLY CONNECTED)    -->
      <!-- ========================================== -->
      <template v-else>
        <!-- Red de conexiones vectoriales densas -->
        <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 340 270">
          <!-- Conexiones verdes de memoria W^(h,h): h1 -> h2 -->
          <g opacity="0.35">
            <line x1="68" y1="36" x2="162" y2="36" stroke="#16a34a" stroke-width="1.2" />
            <line x1="68" y1="36" x2="162" y2="76" stroke="#16a34a" stroke-width="1.2" />
            <line x1="68" y1="36" x2="162" y2="116" stroke="#16a34a" stroke-width="1.2" />
            <line x1="68" y1="36" x2="162" y2="186" stroke="#16a34a" stroke-width="1.2" />

            <line x1="68" y1="96" x2="162" y2="36" stroke="#16a34a" stroke-width="1.2" />
            <line x1="68" y1="96" x2="162" y2="76" stroke="#16a34a" stroke-width="1.2" />
            <line x1="68" y1="96" x2="162" y2="116" stroke="#16a34a" stroke-width="1.2" />
            <line x1="68" y1="96" x2="162" y2="186" stroke="#16a34a" stroke-width="1.2" />
          </g>

          <!-- Conexiones azules de entrada W^(h,x): x2 -> h2 -->
          <g opacity="0.35">
            <line x1="68" y1="156" x2="162" y2="36" stroke="#4f46e5" stroke-width="1.2" />
            <line x1="68" y1="156" x2="162" y2="76" stroke="#4f46e5" stroke-width="1.2" />
            <line x1="68" y1="156" x2="162" y2="116" stroke="#4f46e5" stroke-width="1.2" />
            <line x1="68" y1="156" x2="162" y2="186" stroke="#4f46e5" stroke-width="1.2" />

            <line x1="68" y1="216" x2="162" y2="36" stroke="#4f46e5" stroke-width="1.2" />
            <line x1="68" y1="216" x2="162" y2="76" stroke="#4f46e5" stroke-width="1.2" />
            <line x1="68" y1="216" x2="162" y2="116" stroke="#4f46e5" stroke-width="1.2" />
            <line x1="68" y1="216" x2="162" y2="186" stroke="#4f46e5" stroke-width="1.2" />
          </g>

          <!-- Conexiones rojas de salida W^(y,h): h2 -> y_hat2 -->
          <g opacity="0.5">
            <line x1="190" y1="36" x2="272" y2="114" stroke="#e11d48" stroke-width="1.5" />
            <line x1="190" y1="76" x2="272" y2="114" stroke="#e11d48" stroke-width="1.5" />
            <line x1="190" y1="116" x2="272" y2="114" stroke="#e11d48" stroke-width="1.5" />
            <line x1="190" y1="186" x2="272" y2="114" stroke="#e11d48" stroke-width="1.5" />
          </g>
        </svg>

        <!-- Bloque punteado superior: Memoria Pasada h1 -->
        <div class="absolute rounded-xl border-2 border-dashed border-slate-300 dark:border-zinc-700 pointer-events-none" style="left: 20px; top: 10px; width: 62px; height: 110px;"></div>
        <div class="absolute text-[11px] font-bold text-slate-500" style="left: 4px; top: 52px;" v-html="m('h_1')"></div>
        <div class="absolute text-[10px] font-bold text-emerald-700 dark:text-emerald-400" style="left: 88px; top: 12px;" v-html="m('W^{(h,h)}')"></div>

        <div class="absolute rounded-full border border-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 text-emerald-950 dark:text-emerald-100 flex items-center justify-center text-[10px] font-bold shadow-sm" style="left: 36px; top: 22px; width: 28px; height: 28px;" v-html="m('h_{1,1}')"></div>
        <div class="absolute text-slate-400 font-bold text-xs" style="left: 46px; top: 56px;">⋮</div>
        <div class="absolute rounded-full border border-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 text-emerald-950 dark:text-emerald-100 flex items-center justify-center text-[10px] font-bold shadow-sm" style="left: 36px; top: 82px; width: 28px; height: 28px;" v-html="m('h_{1,M}')"></div>

        <!-- Bloque punteado inferior: Entrada Actual x2 -->
        <div class="absolute rounded-xl border-2 border-dashed border-slate-300 dark:border-zinc-700 pointer-events-none" style="left: 20px; top: 130px; width: 62px; height: 110px;"></div>
        <div class="absolute text-[11px] font-bold text-slate-500" style="left: 4px; top: 172px;" v-html="m('x_2')"></div>
        <div class="absolute text-[10px] font-bold text-indigo-700 dark:text-indigo-400" style="left: 88px; top: 232px;" v-html="m('W^{(h,x)}')"></div>

        <div class="absolute rounded-full border border-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 text-emerald-950 dark:text-emerald-100 flex items-center justify-center text-[10px] font-bold shadow-sm" style="left: 36px; top: 142px; width: 28px; height: 28px;" v-html="m('x_{2,1}')"></div>
        <div class="absolute text-slate-400 font-bold text-xs" style="left: 46px; top: 176px;">⋮</div>
        <div class="absolute rounded-full border border-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 text-emerald-950 dark:text-emerald-100 flex items-center justify-center text-[10px] font-bold shadow-sm" style="left: 36px; top: 202px; width: 28px; height: 28px;" v-html="m('x_{2,P}')"></div>

        <!-- Capa Oculta h2: M Neuronas Densa (Lila) -->
        <div class="absolute text-[10px] font-bold text-rose-700 dark:text-rose-400" style="left: 215px; top: 50px;" v-html="m('W^{(y,h)}')"></div>

        <div class="absolute rounded-full border border-indigo-600 bg-indigo-100 dark:bg-indigo-950/80 text-indigo-950 dark:text-indigo-100 flex items-center justify-center text-[10px] font-bold shadow-sm overflow-hidden" style="left: 162px; top: 22px; width: 28px; height: 28px;">
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-indigo-400 rotate-45"></div>
          <span class="relative z-10" v-html="m('h_{2,1}')"></span>
        </div>
        <div class="absolute rounded-full border border-indigo-600 bg-indigo-100 dark:bg-indigo-950/80 text-indigo-950 dark:text-indigo-100 flex items-center justify-center text-[10px] font-bold shadow-sm overflow-hidden" style="left: 162px; top: 62px; width: 28px; height: 28px;">
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-indigo-400 rotate-45"></div>
          <span class="relative z-10" v-html="m('h_{2,2}')"></span>
        </div>
        <div class="absolute rounded-full border border-indigo-600 bg-indigo-100 dark:bg-indigo-950/80 text-indigo-950 dark:text-indigo-100 flex items-center justify-center text-[10px] font-bold shadow-sm overflow-hidden" style="left: 162px; top: 102px; width: 28px; height: 28px;">
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-indigo-400 rotate-45"></div>
          <span class="relative z-10" v-html="m('h_{2,3}')"></span>
        </div>
        <div class="absolute text-slate-400 font-bold text-xs" style="left: 172px; top: 142px;">⋮</div>
        <div class="absolute rounded-full border border-indigo-600 bg-indigo-100 dark:bg-indigo-950/80 text-indigo-950 dark:text-indigo-100 flex items-center justify-center text-[10px] font-bold shadow-sm overflow-hidden" style="left: 162px; top: 172px; width: 28px; height: 28px;">
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-indigo-400 rotate-45"></div>
          <span class="relative z-10" v-html="m('h_{2,M}')"></span>
        </div>

        <!-- Neurona de Salida y_hat2 (Rojo/Rosa) -->
        <div class="absolute rounded-full border-2 border-rose-600 bg-rose-100 dark:bg-rose-950/60 text-rose-950 dark:text-rose-100 flex items-center justify-center text-xs font-bold shadow-md overflow-hidden" style="left: 272px; top: 96px; width: 36px; height: 36px;">
          <div class="absolute inset-x-0 top-1/2 h-[1px] bg-rose-400 rotate-45"></div>
          <span class="relative z-10" v-html="m('\\hat{y}_2')"></span>
        </div>
      </template>

    </div>

    <!-- Leyenda didáctica con KaTeX al pie -->
    <div 
      class="w-full mt-1.5 p-2 rounded-xl bg-slate-50 dark:bg-zinc-800/80 border border-slate-200 dark:border-zinc-700 text-[11px] leading-snug text-slate-700 dark:text-zinc-200 text-center"
      v-html="explanation"
    ></div>

  </div>
</template>