# Deep Learning - Pontificia Universidad Javeriana Cali (Pregrado)

Repositorio central del **Curso de Deep Learning** (4 sesiones de 2 horas) para estudiantes de pregrado de la Pontificia Universidad Javeriana, sede Cali.

**Tutor:** Jan Polanco Velasco

## Documentación del proyecto

La verdad central del proyecto vive en [`CONSTITUTION.md`](CONSTITUTION.md): contexto del curso, stack técnico, estructura canónica, flujo diario y reglas de ingeniería (Slidev, commits, uv).

## Estructura

```
├── CONSTITUTION.md   # Verdad central del proyecto
├── Makefile          # Comandos Python (uv) y Slidev (pnpm)
├── Slides/           # Presentaciones Slidev (sesión 1-4)
├── Sesiones/         # Material práctico por sesión
└── src/dl_javeriana/ # Código Python reutilizable
```

## Quickstart

```bash
make python-sync    # Entorno Python con uv
make help           # Ver todos los comandos
```
