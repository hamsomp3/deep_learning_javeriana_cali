# -*- coding: utf-8 -*-
"""
Laboratorio 1: Modelos Autorregresivos Profundos (NN-AR)
Caso de Estudio: Pronóstico del Ciclo Solar (Monthly Sunspots 1749 - 1983)
Pontificia Universidad Javeriana Cali — Deep Learning
Tutor: Jan Polanco Velasco
"""

import numpy as np
import pandas as pd
import plotly.graph_objects as go
from scipy.fft import fft, fftfreq
from statsmodels.tsa.seasonal import seasonal_decompose
from sklearn.preprocessing import StandardScaler
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Input
from tensorflow.keras.callbacks import EarlyStopping
from pathlib import Path

# ==============================================================================
# 0. CONFIGURACIÓN INICIAL Y DIRECTORIOS
# ==============================================================================
np.random.seed(42)
tf.random.set_seed(42)

# Directorio de salida compatible con la carpeta public/ de Slidev
output_dir = Path("public/lab01_plots")
output_dir.mkdir(parents=True, exist_ok=True)

print(f"🚀 Iniciando Laboratorio con TensorFlow {tf.__version__}")

# ==============================================================================
# 1. CARGA AUTOMÁTICA DEL DATASET (SIN RUTAS LOCALES FRÁGILES)
# ==============================================================================
URL_SUNSPOTS = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/monthly-sunspots.csv"

print("📥 Descargando dataset oficial de manchas solares...")
df = pd.read_csv(URL_SUNSPOTS)
df.columns = ['Fecha', 'Sunspots']
df['Fecha'] = pd.to_datetime(df['Fecha'])
df.set_index('Fecha', inplace=True)

print(f"✅ Total observaciones: {len(df)} meses (desde {df.index.min().strftime('%Y-%m')} hasta {df.index.max().strftime('%Y-%m')})")
print(df.head(4))

# Gráfico 1: Serie Temporal Completa con Media Móvil de 12 meses
fig_raw = go.Figure()
fig_raw.add_trace(go.Scatter(x=df.index, y=df['Sunspots'], mode='lines', line=dict(color='#94a3b8', width=1), name='Manchas Solares Mensuales'))
fig_raw.add_trace(go.Scatter(x=df.index, y=df['Sunspots'].rolling(12).mean(), mode='lines', line=dict(color='#f59e0b', width=2), name='Media Móvil (1 año)'))
fig_raw.update_layout(
    title="Actividad Solar Histórica (1749 - 1983): Ciclos de ~11 Años",
    xaxis_title="Año",
    yaxis_title="Número de Manchas Solares",
    template="plotly_white",
    hovermode="x unified"
)
fig_raw.write_html(output_dir / "01_serie_historica_solar.html")

# ==============================================================================
# 2. ANÁLISIS ESPECTRAL: TRANSFORMADA RÁPIDA DE FOURIER (FFT)
# ==============================================================================
# Demuestra matemáticamente la periodicidad dominante de la serie temporal
signal = df['Sunspots'].values
n_samples = len(signal)
fft_vals = np.abs(fft(signal - np.mean(signal)))[:n_samples // 2]
frequencies = fftfreq(n_samples, d=1.0)[:n_samples // 2]  # d=1 mes

# El periodo en meses es T = 1 / frecuencia
periods_in_months = 1.0 / frequencies[1:]  # omitir componente DC (f=0)
amplitudes = fft_vals[1:]

dominant_period = periods_in_months[np.argmax(amplitudes)]
print(f"\n🔬 Periodo dominante detectado por Fourier (FFT): {dominant_period:.1f} meses ({dominant_period / 12:.1f} años)")

fig_fft = go.Figure()
fig_fft.add_trace(go.Scatter(x=periods_in_months, y=amplitudes, mode='lines', line=dict(color='#6366f1', width=1.5)))
fig_fft.update_layout(
    title=f"Espectro de Frecuencias (FFT) — Pico Dominante en ~{dominant_period / 12:.1f} años (Ciclo de Schwabe)",
    xaxis=dict(title="Periodo (Meses)", range=[12, 240]),
    yaxis_title="Magnitud",
    template="plotly_white"
)
fig_fft.write_html(output_dir / "02_analisis_fourier_fft.html")

# ==============================================================================
# 3. PARTICIÓN TEMPORAL Y NORMALIZACIÓN RIGUROSA (SIN DATA LEAKAGE)
# ==============================================================================
# En series de tiempo NUNCA se hace muestreo aleatorio. Se respeta el flujo cronológico.
values = df['Sunspots'].values.reshape(-1, 1)

train_size = int(len(values) * 0.8)
train_raw = values[:train_size]
test_raw = values[train_size:]

print(f"\n📊 Partición temporal (80% Train - 20% Test):")
print(f"   - Entrenamiento : {len(train_raw)} meses ({train_size / 12:.1f} años de historia)")
print(f"   - Prueba (Test)  : {len(test_raw)} meses ({len(test_raw) / 12:.1f} años)")

# Ajustamos el escalador ÚNICAMENTE con los datos de entrenamiento
scaler = StandardScaler()
train_scaled = scaler.fit_transform(train_raw)
test_scaled = scaler.transform(test_raw)

# ==============================================================================
# 4. CONSTRUCCIÓN DE LA VENTANA DESLIZANTE (FORMULACIÓN AUTORREGRESIVA)
# ==============================================================================
# Sunspot(k) = f( Sunspot(k-1), Sunspot(k-2), ..., Sunspot(k-n) )
# Tomamos una ventana de 24 meses (2 años de memoria retrospectiva)
WINDOW_SIZE = 24

def build_autoregressive_matrices(series: np.ndarray, window_size: int):
    """
    Transforma la serie unidimensional en pares supervisados (X: retardos, y: futuro inmediato)
    """
    X, y = [], []
    for i in range(len(series) - window_size):
        X.append(series[i : i + window_size, 0])
        y.append(series[i + window_size, 0])
    return np.array(X), np.array(y).reshape(-1, 1)

X_train, y_train = build_autoregressive_matrices(train_scaled, WINDOW_SIZE)
X_test, y_test = build_autoregressive_matrices(test_scaled, WINDOW_SIZE)

print(f"\n🧱 Formulación Autorregresiva con Window Size = {WINDOW_SIZE} retardos:")
print(f"   - Matriz X_train: {X_train.shape} (muestras x retardos)")
print(f"   - Vector y_train: {y_train.shape}")
print(f"   - Matriz X_test : {X_test.shape}")
print(f"   - Vector y_test : {y_test.shape}")

# ==============================================================================
# 5. ARQUITECTURA DEEP LEARNING (RED NEURONAL MULTICAPA - MLP)
# ==============================================================================
# Conectamos con la teoría de la clase:
# 24 entradas -> 16 neuronas (ReLU) -> 8 neuronas (ReLU) -> 1 neurona lineal de salida
model = Sequential([
    Input(shape=(WINDOW_SIZE,), name="Entradas_Retardos_Pasados"),
    Dense(16, activation='relu', name="Capa_Oculta_1"),
    Dense(8, activation='relu', name="Capa_Oculta_2"),
    Dense(1, activation='linear', name="Neurona_Salida_Lineal")
], name="Red_Neuronal_Autorregresiva")

model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.003),
    loss='mse',
    metrics=['mae']
)

model.summary()

# Detención temprana para evitar sobreajuste
early_stop = EarlyStopping(monitor='val_loss', patience=15, restore_best_weights=True)

print("\n🧠 Entrenando Red Neuronal Autorregresiva...")
history = model.fit(
    X_train, y_train,
    validation_data=(X_test, y_test),
    epochs=120,
    batch_size=32,
    callbacks=[early_stop],
    verbose=0
)
print("✅ Entrenamiento completado.")

# Gráfico 3: Pérdida durante el entrenamiento
fig_loss = go.Figure()
fig_loss.add_trace(go.Scatter(y=history.history['loss'], mode='lines', name='Train MSE', line=dict(color='#4f46e5', width=2)))
fig_loss.add_trace(go.Scatter(y=history.history['val_loss'], mode='lines', name='Val MSE', line=dict(color='#ef4444', width=2)))
fig_loss.update_layout(
    title="Evolución de la Función de Costo (MSE) en Entrenamiento y Validación",
    xaxis_title="Época",
    yaxis_title="MSE (Normalizado)",
    template="plotly_white"
)
fig_loss.write_html(output_dir / "03_curva_perdida.html")

# ==============================================================================
# 6. PREDICCIÓN A UN PASO (ONE-STEP-AHEAD FORECASTING)
# ==============================================================================
y_pred_1s_scaled = model.predict(X_test, verbose=0)

# Revertimos la escala a número real de manchas solares
y_test_real = scaler.inverse_transform(y_test)
y_pred_1s_real = scaler.inverse_transform(y_pred_1s_scaled)

mse_1step = np.mean((y_test_real - y_pred_1s_real) ** 2)
mae_1step = np.mean(np.abs(y_test_real - y_pred_1s_real))

print(f"\n🎯 Métricas de Pronóstico a 1 Paso en Test:")
print(f"   - RMSE: {np.sqrt(mse_1step):.2f} manchas")
print(f"   - MAE : {mae_1step:.2f} manchas")

# ==============================================================================
# 7. INFERENCIA RECURSIVA MULTI-PASO (AUTORREGRESIÓN PURA A 6 Y 12 PASOS)
# ==============================================================================
# En lugar de usar valores reales en cada mes, la red se retroalimenta con sus propias predicciones
def recursive_forecast(trained_model, X_start: np.ndarray, horizon: int):
    """
    Ejecuta predicción recursiva sin 'recrear grafos' de Keras en cada paso (alta velocidad).
    """
    total_samples = len(X_start) - horizon + 1
    preds = []

    for i in range(0, total_samples, horizon):
        window = X_start[i].copy()
        block = []
        for _ in range(horizon):
            tensor_in = tf.convert_to_tensor(window.reshape(1, -1), dtype=tf.float32)
            # Inferencia directa mediante tensor call
            next_val = float(trained_model(tensor_in, training=False).numpy()[0, 0])
            block.append(next_val)

            # Desplazamos la ventana: sale el dato más antiguo, entra la predicción
            window = np.roll(window, -1)
            window[-1] = next_val

        preds.extend(block)

    return np.array(preds).reshape(-1, 1)

print("\n🔁 Ejecutando inferencia recursiva a 6 y 12 pasos futuros (1 año de horizonte)...")
y_pred_6s_scaled = recursive_forecast(model, X_test, horizon=6)
y_pred_12s_scaled = recursive_forecast(model, X_test, horizon=12)

# Ajustamos longitud para comparar contra los mismos instantes de test
lim_6 = len(y_pred_6s_scaled)
lim_12 = len(y_pred_12s_scaled)

y_pred_6s_real = scaler.inverse_transform(y_pred_6s_scaled)
y_pred_12s_real = scaler.inverse_transform(y_pred_12s_scaled)

rmse_6s = np.sqrt(np.mean((y_test_real[:lim_6] - y_pred_6s_real) ** 2))
rmse_12s = np.sqrt(np.mean((y_test_real[:lim_12] - y_pred_12s_real) ** 2))

print(f"   - RMSE a 6 meses  (Recursivo): {rmse_6s:.2f} manchas")
print(f"   - RMSE a 12 meses (Recursivo): {rmse_12s:.2f} manchas (propagación acumulada del error)")

# ==============================================================================
# 8. GRÁFICO FINAL COMPARATIVO EN PLOTLY (INTERACTIVO)
# ==============================================================================
# Mostramos un zoom de 120 meses (10 años = 1 ciclo solar completo en el conjunto de prueba)
ZOOM_MONTHS = 120
fig_comp = go.Figure()

fig_comp.add_trace(go.Scatter(
    y=y_test_real[:ZOOM_MONTHS].flatten(),
    mode='lines+markers',
    name='Observaciones Reales',
    line=dict(color='#0f172a', width=2)
))

fig_comp.add_trace(go.Scatter(
    y=y_pred_1s_real[:ZOOM_MONTHS].flatten(),
    mode='lines',
    name=f'1 Paso (RMSE: {np.sqrt(mse_1step):.1f})',
    line=dict(color='#2563eb', width=1.8, dash='dash')
))

fig_comp.add_trace(go.Scatter(
    y=y_pred_6s_real[:ZOOM_MONTHS].flatten(),
    mode='lines',
    name=f'Recursivo 6 Meses (RMSE: {rmse_6s:.1f})',
    line=dict(color='#f59e0b', width=1.8, dash='dot')
))

fig_comp.add_trace(go.Scatter(
    y=y_pred_12s_real[:ZOOM_MONTHS].flatten(),
    mode='lines',
    name=f'Recursivo 12 Meses (RMSE: {rmse_12s:.1f})',
    line=dict(color='#ef4444', width=2)
))

fig_comp.update_layout(
    title=f"Comparativa de Pronóstico Autorregresivo sobre 1 Ciclo Solar Completo ({ZOOM_MONTHS} meses de prueba)",
    xaxis_title="Meses consecutivos de prueba",
    yaxis_title="Número de Manchas Solares",
    template="plotly_white",
    hovermode="x unified",
    legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="center", x=0.5)
)

fig_comp.write_html(output_dir / "04_comparativa_autorregresiva_solar.html")
print(f"\n🎉 ¡Laboratorio completado con éxito! Gráficos interactivos generados en:\n   👉 {output_dir.resolve()}")