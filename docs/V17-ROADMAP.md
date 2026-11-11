# MR. KIMBO Optimizer v17.0 — Roadmap

> Estado: **fundación / diagnóstico**. Este fork conserva el código fuente original de Hellzerg Optimizer 16.7. **No está listo para uso diario.**

## Principios

1. **No romper Windows:** las optimizaciones estarán desactivadas por defecto. No aplicar cambios automáticos al abrir el programa.
2. **Diagnóstico primero:** identificar versión de Windows, servicios, políticas y configuración actual sin alterar el sistema.
3. **Seguridad por diseño:** Windows Update, Windows Security/Defender, SmartScreen, restauración del sistema y servicios críticos no se desactivarán mediante perfiles rápidos.
4. **Reversibilidad:** cada ajuste futuro tendrá registro de su valor original, vista previa, respaldo, y opción de reversión fiable. Evitar “valores de restauración” fijos que ignoren el estado previo.
5. **Resultados comprobables:** no prometer mejoras de FPS ni latencia sin mediciones repetibles.
6. **Separación:** mantener `master` estable; trabajar en ramas `feature/v17-*` y revisar mediante Pull Requests.
7. **Licencia:** conservar GPL-3.0, atribución y código fuente de Hellzerg; marcar modificaciones nuevas.

## Fases

### Fase 0 — Baseline de compilación y auditoría (esta rama)

- [x] Crear fork del proyecto original 16.7.
- [x] Crear rama aislada `feature/v17-safe-foundation`.
- [x] Documentar riesgos concretos del código original.
- [x] Añadir inspección estática de riesgos, **solo lectura**, para CI.
- [x] Actualizar workflow de Windows para restaurar y compilar la solución heredada.
- [ ] Confirmar compilación verde en GitHub Actions. Sin ejecutar la aplicación.
- [ ] Inventariar todas las operaciones privilegiadas, comandos del sistema, registros y servicios antes de realizar cambios.

### Fase 1 — Seguridad y diagnóstico

- [ ] Añadir modo diagnóstico **sin privilegios de administrador**, sin cambios automáticos.
- [ ] Diseñar catálogo de ajustes con compatibilidad de Windows, riesgo y requisitos.
- [ ] Añadir respaldo y reversión basados en estado real previo.
- [ ] Eliminar de los perfiles automatizados la desactivación de Defender, Windows Update, SmartScreen y Restauración.
- [ ] Crear pruebas de reversión en entornos Windows aislados.

### Fase 2 — Experiencia y rendimiento

- [ ] Revisar UI WinForms heredada; modernización gradual sin romper controles existentes.
- [ ] Perfiles Equilibrado, Gaming y Streaming **con vista previa**.
- [ ] Diagnóstico de GPU, CPU, memoria y conflictos de servicios sin supuestos sobre hardware.
- [ ] Español e inglés. Exportar informe local de cambios.

### Fase 3 — Distribución

- [ ] Empaquetado reproducible por GitHub Actions.
- [ ] Validar compatibilidad con Windows 10/11 y regresiones de Windows Update, audio, OBS, red e impresoras.
- [ ] Publicar binarios sólo cuando auditoría, pruebas y permisos estén validados.

## Fuentes

- Upstream: https://github.com/hellzerg/optimizer
- Licencia original: https://github.com/hellzerg/optimizer/blob/master/LICENSE
- Sucesor del autor: https://github.com/hellzerg/optimizerNXT

**Advertencia:** la compilación de la versión heredada no certifica seguridad. No usar la app heredada sobre equipos de producción para validar esta fase.
