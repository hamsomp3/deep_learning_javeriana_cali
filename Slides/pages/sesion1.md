---
id: sesion1
routeAlias: sesion1
title: Sesión 1 - Modelos Auto Regresivos
info: |
  ## Sesión 1: Modelos Auto Regresivos
  DEEP LEARNING
  Pontificia Universidad Javeriana Cali — Pregrado
  Semestre 2026-2 · Tutor: Jan Polanco Velasco
---

<v-click>

# Modelos Auto Regresivos

</v-click>

<v-click>

**Jan Polanco Velasco**

</v-click>


---
layout: two-cols
---

<v-click>



</v-click>

<v-clicks>

- [Regresión Lineal](https://www.researchgate.net/figure/Different-types-of-Machine-Learning-algorithms_fig3_373838363)
- Función de costo
- Gradiente descendente
- Regresión Lineal multivariada
- Regresión Logística

</v-clicks>

::right::

<v-clicks>

![Taxonomía de algoritmos de Machine Learning](/img/sesion1/img01.jpg)

</v-clicks>

---
layout: two-cols
---

<v-click>



</v-click>

<v-click>

# Regresión Lineal

</v-click>

<v-clicks>

- **Relación lineal:** Este modelo describe una relación lineal entre las entradas $x$ y las salidas $y$.
- Donde $w_0$ y $w_1$ *(weights)* representan el intercepto y la pendiente de la recta, respectivamente.


</v-clicks>

<v-clicks>

$$y = w_0 + w_1 \cdot x$$

</v-clicks>

::right::

<v-clicks>


<div class="h-full flex items-center justify-center">
<LinearRegressionPlot />
</div>

</v-clicks>



---
layout: two-cols
---

<v-click>



</v-click>

<v-click>

# Regresión Lineal

</v-click>

<v-clicks>

- Los pesos pueden tomar cualquier valor.
- Diferentes pesos producen diferentes rectas.
- Es necesario calcular la función de costo *(para encontrar los mejores pesos)*.
</v-clicks>

<v-clicks>

$$y = w_0 + w_1 \cdot x$$

</v-clicks>

::right::

<v-clicks>


<div class="h-full flex items-center justify-center">
<LinearRegressionPlot />
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>



</v-click>

<v-click>

# Función de costos

</v-click>

<v-clicks>

- Los pesos pueden tomar cualquier valor.
- Diferentes pesos producen diferentes rectas.
- Es necesario calcular la función de costo *(Los mejores pesos)*.
- **La función de costo (asumiendo $w_0$ conocido):**

</v-clicks>

<v-clicks>

$$\mathcal{L}(w_1) = \sum_{i=1}^{N} (w_1 \cdot x_i - y_i)^2$$

</v-clicks>

::right::

<v-clicks>



<div class="h-full flex items-center justify-center">
<CostFunctionPlot />
</div>
</v-clicks>

---

<v-click>

# 10 Most Common Loss Functions in Machine Learning

</v-click>

<v-click>

## Regression Loss Functions

</v-click>


<v-click>

| Loss Function | Description | Formula |
|---------------|-------------|---------|
| **Mean Bias Error (MBE)** | Captures average bias in prediction. Rarely used for training. | $\mathcal{L}_{MBE} = \frac{1}{N} \sum_{i=1}^N (y_i - f(x_i))$ |
| **Mean Absolute Error (MAE / L1)** | Measures absolute average bias in prediction. | $\mathcal{L}_{MAE} = \frac{1}{N} \sum_{i=1}^N \|y_i - f(x_i)\|$ |
| **Mean Squared Error (MSE / L2)** | Average squared distance between actual and predicted. | $\mathcal{L}_{MSE} = \frac{1}{N} \sum_{i=1}^N (y_i - f(x_i))^2$ |
| **Root Mean Squared Error (RMSE)** | Square root of MSE. Same units as target. | $\mathcal{L}_{RMSE} = \sqrt{\frac{1}{N} \sum_{i=1}^N (y_i - f(x_i))^2}$ |

</v-click>

---

<v-click>

# 10 Most Common Loss Functions in Machine Learning

</v-click>

<v-click>

## Regression Loss Functions

</v-click>

<v-click>

| Loss Function | Description | Formula |
|---------------|-------------|---------|
| **Huber Loss** | Combination of MSE and MAE. Parametric robust loss. | $\mathcal{L}_{\delta} = \begin{cases} \frac{1}{2}(y - f(x))^2 & \text{si } \|y - f(x)\| \le \delta \\ \delta(\|y - f(x)\| - \frac{1}{2}\delta) & \text{en otro caso} \end{cases}$ |
| **Log Cosh Loss** | Similar to Huber, non-parametric, twice differentiable. | $\mathcal{L}_{\log\cosh} = \sum_{i=1}^N \log(\cosh(f(x_i) - y_i))$ |

</v-click>

---

<v-click>

# 10 Most Common Loss Functions in Machine Learning

</v-click>


<v-click>

## Classification Loss Functions

</v-click>


<v-click>

| Loss Function | Description | Formula |
|---------------|-------------|---------|
| **Binary Cross Entropy (BCE)** | Loss function for binary classification tasks. | $\mathcal{L}_{BCE} = -\frac{1}{N} \sum [y_i \log p(x_i) + (1-y_i) \log(1-p(x_i))]$ |
| **Hinge Loss** | Penalizes wrong and low-confidence predictions (SVMs). | $\mathcal{L}_{\text{hinge}} = \max(0, 1 - f(x) \cdot y)$ |
| **Categorical Cross Entropy** | Multi-class classification extension of BCE. | $\mathcal{L}_{CE} = -\frac{1}{N}\sum \sum y_{ij} \log(f(x_{ij}))$ |
| **KL Divergence** | Relative entropy between true and predicted distributions. | $\mathcal{L}_{KL} = \sum y_i \cdot \log\left(\frac{y_i}{f(x_i)}\right)$ |

</v-click>

---
layout: two-cols
---

<v-click>



</v-click>


<v-click>

# Gradiente Descendente

</v-click>

<v-click>

$$\mathcal{L}(w_1) = \sum_{i=1}^N (w_1 \cdot x_i - y_i)^2$$

</v-click>

<v-click>

$$w^{(t+1)} = w^{(t)} - \alpha \nabla f_i(w^{(t)})$$

</v-click>

<v-clicks>

- **$w^{(t+1)}$**: Posición de la siguiente iteración
- **$w^{(t)}$**: Posición del paso anterior
- **$\alpha$**: Tasa de aprendizaje *(learning rate / step size)*
- **$\nabla f_i(w^{(t)})$**: Gradiente en la observación $i$

</v-clicks>

::right::

<v-clicks>


![Gráfica de pasos hacia el mínimo global](/img/sesion1/img05.jpg)

</v-clicks>



---
layout: two-cols
---

<v-click>



# Gradiente Descendente

</v-click>

<v-clicks>

$$\mathcal{L}(w_1) = \sum_{i=1}^N (w_1 \cdot x_i - y_i)^2$$

$$w^{(t+1)} = w^{(t)} - \alpha \nabla f_i(w^{(t)})$$

</v-clicks>

::right::

<v-clicks>


![*(Superficie no convexa $J(\theta_0, \theta_1)$ y trayectoria de convergencia hacia un mínimo)*](/img/sesion1/img06.jpg)

</v-clicks>

---
layout: two-cols
---



# Gradiente Descendente


$$\mathcal{L}(w_1) = \sum_{i=1}^N (w_1 \cdot x_i - y_i)^2$$

$$w^{(t+1)} = w^{(t)} - \alpha \nabla f_i(w^{(t)})$$



::right::

<v-clicks>


![*(Superficie no convexa $J(\theta_0, \theta_1)$ y trayectoria de convergencia hacia un mínimo)*](/img/sesion1/img07.jpg)

</v-clicks>

---
layout: two-cols
---




# Gradiente Descendente


$$\mathcal{L}(w_1) = \sum_{i=1}^N (w_1 \cdot x_i - y_i)^2$$

$$w^{(t+1)} = w^{(t)} - \alpha \nabla f_i(w^{(t)})$$


::right::

<v-clicks>


![*(Superficie no convexa $J(\theta_0, \theta_1)$ y trayectoria de convergencia hacia un mínimo)*](/img/sesion1/img08.jpg)

</v-clicks>

---
layout: two-cols
---

<v-click>



# Regresión Lineal Multivariada

</v-click>

<v-clicks>

- Se puede aplicar a datos con **múltiples atributos**.
- Los parámetros del modelo se estiman a partir de los conceptos de **Función de costo** y **Gradiente descendente**.

$$\hat{y} = w_0 + \sum_{j=1}^m w_j \cdot x_j$$

</v-clicks>

::right::

<div class="h-full flex items-center justify-center">
<div class="relative w-[280px] h-[330px] mx-auto select-none font-serif">
  <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 280 330">
  <defs>
  <marker id="arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
  <path d="M 0 1.5 L 8 5 L 0 8.5 z" class="fill-[#1e296b] dark:fill-indigo-300" />
  </marker>
  </defs>
  <line x1="62" y1="38" x2="214" y2="152" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="64" y1="102" x2="210" y2="158" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="65" y1="166" x2="209" y2="166" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="62" y1="280" x2="214" y2="180" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  </svg>
  <span class="absolute left-[128px] top-[85px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">0</sub>
  </span>
  <span class="absolute left-[128px] top-[120px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">1</sub>
  </span>
  <span class="absolute left-[128px] top-[158px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">2</sub>
  </span>
  <span class="absolute left-[126px] top-[225px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] italic">m</sub>
  </span>
  <div class="absolute left-[20px] top-[16px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif shadow-sm">
    1
  </div>
  <div class="absolute left-[20px] top-[80px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">1</sub>
  </div>
  <div class="absolute left-[20px] top-[144px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">2</sub>
  </div>
  <div class="absolute left-[20px] top-[204px] w-11 flex justify-center text-2xl font-serif text-slate-700 dark:text-slate-300">
    &#8942;
  </div>
  <div class="absolute left-[20px] top-[258px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs italic">m</sub>
  </div>
  <div class="absolute left-[215px] top-[144px] w-11 h-11 rounded-full border-2 border-[#991b1b] bg-[#fca5a5] text-[#7f1d1d] flex items-center justify-center text-xl font-serif italic shadow-sm">
    ŷ
  </div>
</div>
</div>

---
layout: two-cols
---

<v-click>



# Regresión Lineal Multivariada

</v-click>

<v-clicks>

- En este caso, la predicción se calcula como una **combinación lineal** de todos los atributos de entrada.

$$\hat{y} = w_0 + \sum_{j=1}^m w_j \cdot x_j$$

</v-clicks>

::right::

<div class="h-full flex items-center justify-center">
<div class="relative w-[280px] h-[330px] mx-auto select-none font-serif">
  <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 280 330">
  <defs>
  <marker id="arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
  <path d="M 0 1.5 L 8 5 L 0 8.5 z" class="fill-[#1e296b] dark:fill-indigo-300" />
  </marker>
  </defs>
  <line x1="62" y1="38" x2="214" y2="152" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="64" y1="102" x2="210" y2="158" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="65" y1="166" x2="209" y2="166" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="62" y1="280" x2="214" y2="180" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  </svg>
  <span class="absolute left-[128px] top-[85px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">0</sub>
  </span>
  <span class="absolute left-[128px] top-[120px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">1</sub>
  </span>
  <span class="absolute left-[128px] top-[158px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">2</sub>
  </span>
  <span class="absolute left-[126px] top-[225px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] italic">m</sub>
  </span>
  <div class="absolute left-[20px] top-[16px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif shadow-sm">
    1
  </div>
  <div class="absolute left-[20px] top-[80px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">1</sub>
  </div>
  <div class="absolute left-[20px] top-[144px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">2</sub>
  </div>
  <div class="absolute left-[20px] top-[204px] w-11 flex justify-center text-2xl font-serif text-slate-700 dark:text-slate-300">
    &#8942;
  </div>
  <div class="absolute left-[20px] top-[258px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs italic">m</sub>
  </div>
  <div class="absolute left-[215px] top-[144px] w-11 h-11 rounded-full border-2 border-[#991b1b] bg-[#fca5a5] text-[#7f1d1d] flex items-center justify-center text-xl font-serif italic shadow-sm">
    ŷ
  </div>
</div>
</div>

---
layout: two-cols
---

<v-click>



# Regresión Logística

</v-click>

<v-clicks>

- Realiza predicciones a partir de una combinación lineal.
- Se mide la probabilidad de que una instancia pertenezca a una de las dos clases (**clasificación binaria**).

</v-clicks>

<v-clicks>

$$\hat{y} = p(y = 1 \mid \mathbf{x}) = \sigma \left( w_0 + \sum_{j=1}^m w_j x_j \right)$$

</v-clicks>


<v-clicks>

*Donde:*

</v-clicks>

<v-clicks>

- $\hat{y}$ es la probabilidad de que $y = 1$ dado el vector de atributos $\mathbf{x}$.
- $\sigma(\cdot)$ es la función sigmoide.

</v-clicks>

::right::

<div class="h-full flex items-center justify-center">
<div class="relative w-[280px] h-[330px] mx-auto select-none font-serif">
  <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 280 330">
  <defs>
  <marker id="arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
  <path d="M 0 1.5 L 8 5 L 0 8.5 z" class="fill-[#1e296b] dark:fill-indigo-300" />
  </marker>
  </defs>
  <line x1="62" y1="38" x2="214" y2="152" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="64" y1="102" x2="210" y2="158" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="65" y1="166" x2="209" y2="166" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="62" y1="280" x2="214" y2="180" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  </svg>
  <span class="absolute left-[128px] top-[85px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">0</sub>
  </span>
  <span class="absolute left-[128px] top-[120px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">1</sub>
  </span>
  <span class="absolute left-[128px] top-[158px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">2</sub>
  </span>
  <span class="absolute left-[126px] top-[225px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] italic">m</sub>
  </span>
  <div class="absolute left-[20px] top-[16px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif shadow-sm">
    1
  </div>
  <div class="absolute left-[20px] top-[80px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">1</sub>
  </div>
  <div class="absolute left-[20px] top-[144px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">2</sub>
  </div>
  <div class="absolute left-[20px] top-[204px] w-11 flex justify-center text-2xl font-serif text-slate-700 dark:text-slate-300">
    &#8942;
  </div>
  <div class="absolute left-[20px] top-[258px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs italic">m</sub>
  </div>
  <div class="absolute left-[215px] top-[144px] w-11 h-11 rounded-full border-2 border-[#991b1b] bg-[#fca5a5] text-[#7f1d1d] flex items-center justify-center text-xl font-serif italic shadow-sm">
    ŷ
  </div>
</div>
</div>

---
layout: two-cols
---

<v-click>



</v-click>

<v-click>

# Regresión Logística

</v-click>

<v-clicks>

- La combinación lineal toma cualquier valor real.
- Para mapear la predicción a una **probabilidad**, se usa la **función sigmoidal**.

</v-clicks>

<v-clicks>

$$\hat{y} = p(y = 1 \mid \mathbf{x}) = \sigma \left( w_0 + \sum_{j=1}^m w_j x_j \right)$$

</v-clicks>

<v-clicks>

*Donde:*

</v-clicks>


<v-clicks>

- $\hat{y}$ es la probabilidad de que $y = 1$ dado el vector de atributos $\mathbf{x}$.
- $\sigma(\cdot)$ es la función sigmoide.
</v-clicks>

::right::

<div class="h-full flex items-center justify-center">
<div class="relative w-[280px] h-[330px] mx-auto select-none font-serif">
  <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 280 330">
  <defs>
  <marker id="arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
  <path d="M 0 1.5 L 8 5 L 0 8.5 z" class="fill-[#1e296b] dark:fill-indigo-300" />
  </marker>
  </defs>
  <line x1="62" y1="38" x2="214" y2="152" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="64" y1="102" x2="210" y2="158" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="65" y1="166" x2="209" y2="166" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  <line x1="62" y1="280" x2="214" y2="180" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#arrow)" />
  </svg>
  <span class="absolute left-[128px] top-[85px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">0</sub>
  </span>
  <span class="absolute left-[128px] top-[120px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">1</sub>
  </span>
  <span class="absolute left-[128px] top-[158px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] not-italic">2</sub>
  </span>
  <span class="absolute left-[126px] top-[225px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212] leading-none">
    w<sub class="text-[10px] italic">m</sub>
  </span>
  <div class="absolute left-[20px] top-[16px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif shadow-sm">
    1
  </div>
  <div class="absolute left-[20px] top-[80px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">1</sub>
  </div>
  <div class="absolute left-[20px] top-[144px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs not-italic">2</sub>
  </div>
  <div class="absolute left-[20px] top-[204px] w-11 flex justify-center text-2xl font-serif text-slate-700 dark:text-slate-300">
    &#8942;
  </div>
  <div class="absolute left-[20px] top-[258px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg font-serif italic shadow-sm">
    x<sub class="text-xs italic">m</sub>
  </div>
  <div class="absolute left-[215px] top-[144px] w-11 h-11 rounded-full border-2 border-[#991b1b] bg-[#fca5a5] text-[#7f1d1d] flex items-center justify-center text-xl font-serif italic shadow-sm">
    ŷ
  </div>
</div>
</div>

---
layout: two-cols
---

# Regresión Logística

<v-clicks>

- **Clasificación binaria:** Modela la probabilidad de que una instancia pertenezca a la clase positiva ($y = 1$).
- **Combinación lineal acotada:** Pasa la pre-activación $z$ por la <span v-mark.circle.emerald="1">función sigmoide $\sigma(z)$</span> para garantizar un rango en $[0, 1]$.

$$\hat{y} = p(y = 1 \mid \mathbf{x}) = \sigma \left( w_0 + \sum_{j=1}^m w_j x_j \right)$$

- **Función de costo:** En lugar de MSE, se optimiza mediante **Entropía Cruzada Binaria (BCE)**.

</v-clicks>

::right::

<div class="h-full flex items-center justify-center">
<div class="relative w-[280px] h-[330px] mx-auto select-none font-serif">
  <svg class="absolute inset-0 w-full h-full pointer-events-none" viewBox="0 0 280 330">
  <defs>
  <marker id="log-arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
  <path d="M 0 1.5 L 8 5 L 0 8.5 z" class="fill-[#1e296b] dark:fill-indigo-300" />
  </marker>
  </defs>
  <line x1="62" y1="38" x2="210" y2="152" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#log-arrow)" />
  <line x1="64" y1="102" x2="208" y2="158" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#log-arrow)" />
  <line x1="65" y1="166" x2="206" y2="166" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#log-arrow)" />
  <line x1="62" y1="280" x2="210" y2="180" class="stroke-[#1e296b] dark:stroke-indigo-300" stroke-width="2" marker-end="url(#log-arrow)" />
  </svg>
  <span class="absolute left-[128px] top-[85px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212]">w₀</span>
  <span class="absolute left-[128px] top-[120px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212]">w₁</span>
  <span class="absolute left-[128px] top-[158px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212]">w₂</span>
  <span class="absolute left-[126px] top-[225px] px-0.5 text-sm font-serif italic text-[#1e296b] dark:text-indigo-300 bg-white dark:bg-[#121212]">wₘ</span>
  <div class="absolute left-[20px] top-[16px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg shadow-sm">1</div>
  <div class="absolute left-[20px] top-[80px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg italic shadow-sm">x₁</div>
  <div class="absolute left-[20px] top-[144px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg italic shadow-sm">x₂</div>
  <div class="absolute left-[20px] top-[204px] w-11 flex justify-center text-2xl text-slate-700 dark:text-slate-300">⋮</div>
  <div class="absolute left-[20px] top-[258px] w-11 h-11 rounded-full border-2 border-[#166534] bg-[#9de2b8] text-[#14532d] flex items-center justify-center text-lg italic shadow-sm">xₘ</div>
  <div class="absolute left-[210px] top-[140px] w-14 h-14 rounded-full border-2 border-emerald-600 bg-emerald-100 dark:bg-emerald-950/60 text-emerald-900 dark:text-emerald-200 flex flex-col items-center justify-center shadow-lg">
  <span class="font-serif italic font-bold text-sm leading-none">σ(z)</span>
  <span class="text-[10px] font-sans font-semibold text-emerald-700 dark:text-emerald-300 leading-none mt-0.5">ŷ ∈ [0,1]</span>
  </div>
</div>
</div>

---

<v-click>



# Red Neuronal Fully Connected

</v-click>

<v-clicks>

- **Capa de Entrada** *(Input Layer)*
- **Capa oculta** *(Hidden Layer - $h$)*
- **Capa de salida** *(Output Layer)*

</v-clicks>

<v-click>

### ¿Cuántas capas tiene la NN?
*(Modelo biológico de la neurona: dendritas, soma/núcleo, axón vs modelo artificial de suma ponderada + activación)*


<div style="zoom: 0.55;">

![Taxonomía de algoritmos de Machine Learning](/img/sesion1/Artificial-Neurons-a-computational-model-Source.png)

</div>

</v-click>

---

<v-click>



# Red Neuronal Fully Connected

</v-click>

<v-clicks>

- La capa de entrada **no suele considerarse** en el conteo de capas.
- **Tiene 4 capas:** $L = 4$ *(3 capas ocultas + 1 capa de salida)*.

</v-clicks>

<v-clicks>

<div class="mt-4 flex justify-center">
  <NeuralNetwork />
</div>

</v-clicks>

---
layout: two-cols
---

<v-click>



</v-click>

<v-clicks>

- El **superíndice** indica la capa.
- $h_1$ necesita $3 + 1$ parámetros.
- La primera capa oculta necesita $4 \times 5$ parámetros.

</v-clicks>

<v-click>

### Ecuación general para $h_1$:
$$h_1 = g\left( w_{1,0}^{[1]} + \sum_{j=1}^3 w_{1,j}^{[1]} x_j \right)$$

- $g(\cdot)$: Función de activación (ReLU, sigmoide, etc.)
- $w_{1,0}^{[1]}$: Bias o término de sesgo.
- $w_{1,j}^{[1]}$: Peso asociado a cada entrada $x_j$.

</v-click>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2" style="zoom: 0.95;">
<NeuronDetail />
</div>

</v-clicks>


---
layout: two-cols
---

<v-click>



# Cálculo de la neurona de salida $\hat{y}$

</v-click>

<v-clicks>

$$\hat{y} = g\left( w_{1,0}^{[2]} + \sum_{j=1}^3 w_{1,j}^{[2]} h_j \right)$$

- Ponderación de los estados ocultos $h_1, h_2, h_3$ junto al sesgo $w_{1,0}^{[2]}$.

</v-clicks>

::right::

<v-clicks>

<div class="h-full flex items-center justify-center pl-2">
<OutputNeuronCalculation />
</div>
</v-clicks>

---

<v-click>



# Funciones de Activación

</v-click>

<v-clicks>

- **Añaden No Linealidad:** Las funciones de activación son esenciales para agregar un componente no lineal en las redes neuronales, permitiendo que estas redes puedan aprender y modelar relaciones complejas en los datos.
- **Modelo Lineal sin Activación:** Sin funciones de activación, una red neuronal se reduce a un simple modelo lineal, sin importar cuántas capas ocultas contenga.
- **En Cualquier Capa:** Las funciones de activación pueden colocarse en cualquier capa de la red.

</v-clicks>

---

<v-click>



# Funciones de Activación

</v-click>

<v-clicks>

- Ciertas funciones son más apropiadas para **capas de salida**.
- Otras son mejores para **capas ocultas**, optimizando el rendimiento de la red.

</v-clicks>

<v-click>

### Definición Matemática
Para una unidad en una capa oculta o de salida, el cálculo del valor se realiza mediante la función de activación $g(\cdot)$:

$$h_2 = g\left( w_{2,0}^{[1]} + \sum_{j=1}^4 w_{2,j}^{[1]} x_j \right)$$

</v-click>


---
layout: two-cols
---

<v-click>

# Tipos de Funciones de Activación: Identidad

</v-click>

<v-clicks>

- **Función Identidad:** $f(x) = x$
- Salida igual a la entrada.
- En capas ocultas produce un modelo puramente lineal *(pierde la capacidad de aproximar no linealidades)*.
- **Se suele usar en la capa de salida** para problemas de regresión continua.

</v-clicks>

::right::

<div class="h-full flex items-center justify-center pl-2">
  <ActivationPlot type="identity" />
</div>

---
layout: two-cols
---

<v-click>

# Tipos de Funciones de Activación: Sigmoide

</v-click>

<v-clicks>

- **Función sigmoide:** $\sigma(x) = \frac{1}{1 + e^{-x}}$
- **Rango de salida:** $[0, 1]$ *(ideal para interpretar probabilidades)*.
- Introduce problemas de **saturación de gradientes** en valores extremos ($|x| > 3$).
- **Softmax** es la versión generalizada para clasificación multiclase en la capa de salida.

</v-clicks>

::right::

<div class="h-full flex items-center justify-center pl-2">
  <ActivationPlot type="sigmoid" />
</div>

---
layout: two-cols
---

<v-click>

# Tipos de Funciones de Activación: Tangente Hiperbólica

</v-click>

<v-clicks>

- **Función Tangente Hiperbólica:** $\tanh(x) = \frac{e^x - e^{-x}}{e^x + e^{-x}}$
- **Rango de salida:** $[-1, 1]$.
- **Centrada en cero:** Facilita la convergencia del entrenamiento frente a la sigmoide.
- Sufre del problema de **gradientes que se desvanecen** *(vanishing gradient)* en las colas.

</v-clicks>

::right::

<div class="h-full flex items-center justify-center pl-2">
  <ActivationPlot type="tanh" />
</div>

---
layout: two-cols
---

<v-click>

# Tipos de Funciones de Activación: ReLU

</v-click>

<v-clicks>

- **Función ReLU** *(Rectified Linear Unit)*:
  $$f(x) = \max(0, x)$$
- Computacionalmente muy eficiente: cálculo directo sin exponenciales.
- Evita la saturación del gradiente para $x > 0$.
- Estándar por defecto en **capas ocultas**.

</v-clicks>

::right::

<div class="h-full flex items-center justify-center pl-2">
  <ActivationPlot type="relu" />
</div>


---

<v-click>

# Subconjunto de Funciones de Activación

</v-click>

| Función | Fórmula | Función | Fórmula |
|---|---|---|---|
| **ReLU** | $\max(0, x)$ | **GELU** | $\frac{x}{2}\left(1 + \tanh\left(\sqrt{\frac{2}{\pi}}(x + 0.044715x^3)\right)\right)$ |
| **PReLU** | $\max(0, x) + \alpha \min(0, x)$ | **ELU** | $\begin{cases} x & x > 0 \\ \alpha(e^x - 1) & x \le 0 \end{cases}$ |
| **Swish** | $\frac{x}{1 + e^{-x}}$ | **SELU** | $\lambda \begin{cases} x & x > 0 \\ \alpha(e^x - 1) & x \le 0 \end{cases}$ |
| **SoftPlus** | $\frac{1}{\beta}\log(1 + \exp(\beta x))$ | **Mish** | $x \cdot \tanh(\text{softplus}(x))$ |
| **Sigmoid** | $\frac{1}{1 + e^{-x}}$ | **SoftSign** | $\frac{x}{1 + \|x\|}$ |
| **Tanh** | $\tanh(x)$ | **Hard Tanh** | $\max(-1, \min(1, x))$ |

---

<v-click>



# Estimación de Hiperparámetros

</v-click>

<v-clicks>

- **Parámetros:** Son los pesos $w$ y sesgos calculados por optimización.
- **Hiperparámetros:** Son los valores configurados externamente que afectan el aprendizaje de los parámetros.
  - Cantidad de capas.
  - Learning Rate (tamaño del paso en Gradient Descent).
- Ser cuidadosos con la elección de la **función de costo**.

</v-clicks>

---

<v-click>



# Selección de Funciones y Optimizadores

</v-click>

<v-clicks>

- **En regresión:** Se suele usar **RMSE** o **MSE**.
- **En clasificación binaria:** Se suele usar **entropía cruzada binaria (BCE)**.
- **En multiclase:** **Entropía cruzada categórica (CCE)**.
- **Solvers / Optimizadores:** Gradient Descent (GD), ADAM, RMSprop, etc.

</v-clicks>

---

<v-click>



# Hiperparámetros de Arquitectura

</v-click>

<v-clicks>

- **$L$:** Cantidad de capas o profundidad de la red.
- **Número de unidades por capa:** La entrada y salida dependen directamente de la definición del problema.
- **Estructura fija:** Rectangular (mismo número de unidades por capa oculta).
- **Estructura variable:** Piramidal (reducción progresiva de neuronas por capa).

</v-clicks>

---
layout: two-cols
---

<v-click>



# Hiperparámetros de Entrenamiento

</v-click>

<v-clicks>

- **Learning Rate (LR)**
- **Funciones de activación**
- **Batch size** y **Epochs**
- **Procesos de regularización** (Dropout, Weight Decay)
- Estrategias de prueba: *Trial and Error*
- **Partición de datos:**
  - `60% / 20% / 20%` (pocos datos)
  - `90% / 5% / 5%` (grandes volúmenes)
- **Técnicas de búsqueda:**
  - Grid Search
  - Random Search
  - Bayesian Search

</v-clicks>

::right::

<v-clicks>

- **Grid Search:** Búsqueda exhaustiva en malla regular.
- **Random Search:** Muestreo aleatorio en el espacio continuo.
- **Bayesian Search:** Optimización probabilística guiada por evaluaciones previas.

</v-clicks>

---
class: text-center
---

<v-click>



</v-click>

<v-clicks>

# 🎮 Juguemos un rato con una NN

*(Demostración práctica interactiva / TensorFlow Playground)*

</v-clicks>

---

<v-click>



# Datos Secuenciales

</v-click>

<v-clicks>

- ¿Qué son los datos secuenciales?

*(Ejemplo: series financieras, índice bursátil Dow Jones a lo largo del tiempo)*

</v-clicks>

---

<v-click>



# Datos Secuenciales

</v-click>

<v-clicks>

- ¿Qué son los datos secuenciales?
- **El dato actual depende de la información anterior.**
- **Dependencia temporal.**

</v-clicks>

---

<v-click>



# Ejemplos de Datos Secuenciales

</v-click>

<v-clicks>

- **Series de tiempo**
- **Señales de sensores**
- **La voz (audio)**
- **Secuencia de genes** *(gene sequences)*
- **Información climática**

</v-clicks>

---
layout: two-cols
---

<v-click>



# Limitaciones de las NN Tradicionales

</v-click>

<v-clicks>

- Una NN tradicional **asume que los datos no son secuenciales** y que cada punto de datos es independiente de otros puntos de datos ($i.i.d.$).
- **Ejemplo:** Temperatura – Humedad.
- **Carecen de memoria.**
- **Sufren de gradientes que se desvanecen** *(vanishing gradients)* con secuencias largas.

</v-clicks>

::right::

<div class="h-full flex items-center justify-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-xl select-none text-center">
  <div class="text-xs font-mono text-slate-500 mb-2 font-bold">NN Densa — sin memoria temporal:</div>
  <svg viewBox="0 0 300 220" class="w-[300px] h-[220px]">
  <defs>
  <marker id="nn-arr" viewBox="0 0 10 10" refX="7" refY="5" markerWidth="5" markerHeight="5" orient="auto">
  <path d="M 0 2 L 7 5 L 0 8 z" class="fill-slate-600 dark:fill-zinc-400" />
  </marker>
  </defs>
  <text x="45" y="18" text-anchor="middle" class="text-[10px] font-bold fill-slate-500">Input</text>
  <text x="150" y="18" text-anchor="middle" class="text-[10px] font-bold fill-slate-500">Hidden</text>
  <text x="245" y="18" text-anchor="middle" class="text-[10px] font-bold fill-slate-500">Output</text>
  <line x1="58" y1="60" x2="132" y2="75" class="stroke-slate-500 dark:stroke-zinc-500" stroke-width="1.5" marker-end="url(#nn-arr)" />
  <line x1="58" y1="60" x2="132" y2="145" class="stroke-slate-500 dark:stroke-zinc-500" stroke-width="1.5" marker-end="url(#nn-arr)" />
  <line x1="58" y1="140" x2="132" y2="75" class="stroke-slate-500 dark:stroke-zinc-500" stroke-width="1.5" marker-end="url(#nn-arr)" />
  <line x1="58" y1="140" x2="132" y2="145" class="stroke-slate-500 dark:stroke-zinc-500" stroke-width="1.5" marker-end="url(#nn-arr)" />
  <line x1="168" y1="75" x2="228" y2="110" class="stroke-slate-500 dark:stroke-zinc-500" stroke-width="1.5" marker-end="url(#nn-arr)" />
  <line x1="168" y1="145" x2="228" y2="110" class="stroke-slate-500 dark:stroke-zinc-500" stroke-width="1.5" marker-end="url(#nn-arr)" />
  <rect x="10" y="42" width="48" height="36" rx="8" class="fill-blue-100 stroke-blue-600 dark:fill-blue-950/70 dark:stroke-blue-400" stroke-width="2" />
  <text x="34" y="64" text-anchor="middle" class="text-[10px] font-serif italic font-bold fill-blue-900 dark:fill-blue-200">Temp</text>
  <rect x="10" y="122" width="48" height="36" rx="8" class="fill-blue-100 stroke-blue-600 dark:fill-blue-950/70 dark:stroke-blue-400" stroke-width="2" />
  <text x="34" y="144" text-anchor="middle" class="text-[10px] font-serif italic font-bold fill-blue-900 dark:fill-blue-200">Hum</text>
  <circle cx="150" cy="75" r="20" class="fill-emerald-100 stroke-emerald-600 dark:fill-emerald-950/70 dark:stroke-emerald-400" stroke-width="2" />
  <text x="150" y="79" text-anchor="middle" class="text-[11px] font-serif italic font-bold fill-emerald-900 dark:fill-emerald-200">h₁</text>
  <circle cx="150" cy="145" r="20" class="fill-emerald-100 stroke-emerald-600 dark:fill-emerald-950/70 dark:stroke-emerald-400" stroke-width="2" />
  <text x="150" y="149" text-anchor="middle" class="text-[11px] font-serif italic font-bold fill-emerald-900 dark:fill-emerald-200">h₂</text>
  <circle cx="245" cy="110" r="22" class="fill-rose-100 stroke-rose-600 dark:fill-rose-950/70 dark:stroke-rose-400" stroke-width="2" />
  <text x="245" y="114" text-anchor="middle" class="text-[11px] font-serif italic font-bold fill-rose-900 dark:fill-rose-200">ŷ</text>
  <rect x="200" y="175" width="90" height="28" rx="6" class="fill-amber-100 stroke-amber-600 dark:fill-amber-950/70 dark:stroke-amber-400" stroke-width="1.5" />
  <text x="245" y="193" text-anchor="middle" class="text-[10px] font-bold fill-amber-900 dark:fill-amber-200">Output Class</text>
  <line x1="245" y1="132" x2="245" y2="173" class="stroke-slate-600 dark:stroke-zinc-400" stroke-width="1.5" marker-end="url(#nn-arr)" />
  <text x="150" y="210" text-anchor="middle" class="text-[9px] fill-slate-400 dark:fill-slate-500">cada muestra se procesa de forma independiente (i.i.d.)</text>
  </svg>
</div>
</div>

---
layout: two-cols
---

# Redes Neuronales Autorregresivas (NN-AR)

### De serie temporal a problema supervisado

<v-clicks>

- **Idea central:** Transformar una secuencia temporal $T_1, T_2, \dots, T_k$ en pares de entrenamiento $(X, Y)$ mediante una <span v-mark.underline.orange="1">ventana deslizante (*lagged features*)</span>.
- **Formulación matemática:**
  $$T(k) = f_{\theta}\big(T(k-1), T(k-2), \dots, T(k-n)\big)$$
- **Parámetro $n$ (*window size*):** Cantidad de retardos pasados que alimentan la capa de entrada.
- El modelo es una MLP densa entrenada con función de costo **MSE**.

</v-clicks>

::right::

<div class="h-full flex flex-col justify-center items-center pl-2">
<div class="p-4 rounded-2xl bg-white/80 dark:bg-zinc-900/80 border border-slate-200 dark:border-zinc-800 shadow-lg text-xs font-mono select-none w-full">
  <div class="text-slate-500 mb-2 font-sans font-bold">Concepto de Ventana Deslizante ($n=3$):</div>
  <div class="space-y-1.5">
  <div class="p-1.5 rounded bg-blue-50 dark:bg-blue-950/40 border border-blue-200 dark:border-blue-900 flex justify-between">
  <span>X₁: [T₁, T₂, T₃]</span> <span class="text-rose-600 font-bold">→ Y₁: T₄</span>
  </div>
  <div class="p-1.5 rounded bg-blue-50 dark:bg-blue-950/40 border border-blue-200 dark:border-blue-900 flex justify-between">
  <span>X₂: [T₂, T₃, T₄]</span> <span class="text-rose-600 font-bold">→ Y₂: T₅</span>
  </div>
  <div class="p-1.5 rounded bg-blue-50 dark:bg-blue-950/40 border border-blue-200 dark:border-blue-900 flex justify-between">
  <span>X₃: [T₃, T₄, T₅]</span> <span class="text-rose-600 font-bold">→ Y₃: T₆</span>
  </div>
  </div>
  <div class="mt-3 text-[11px] text-slate-500 font-sans">
    La red densa aprende la dinámica temporal mapeando vectores fijos del pasado hacia el siguiente paso futuro.
  </div>
</div>
</div>
---

# Construyendo la Arquitectura en Keras

````md magic-move
```python
# 1. Regresión Lineal Clásica (1 sola neurona lineal)
model = Sequential([
    Input(shape=(10,)),
    Dense(1, activation='linear')
])
```
```python
# 2. Red Neuronal Profunda (MLP No Lineal para la serie temporal)
model = Sequential([
    Input(shape=(10,)),
    Dense(16, activation='relu'),    # 1ª Capa oculta: extrae patrones locales
    Dense(8, activation='relu'),     # 2ª Capa oculta: combina representaciones
    Dense(1, activation='linear')    # Capa de salida: pronóstico de temperatura
])
```
```python
# 3. Compilación y Entrenamiento con Gradiente Descendente
model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
    loss='mse',
    metrics=['mae']
)

history = model.fit(
    X_train, y_train,
    validation_data=(X_val, y_val),
    epochs=150,
    batch_size=32,
    verbose=1
)
```

