# v17.0 — Matriz de validación antes de publicar

**Alcance actual:** planificación de pruebas. **La compilación por sí sola no significa que el optimizador sea seguro.**

## Etapa A: CI estática (GitHub Actions)

- [ ] Restaurar paquetes NuGet sin errores.
- [ ] Compilar el código heredado en runner Windows.
- [ ] Inspeccionar riesgos del código sin ejecutar el optimizador.
- [ ] Verificar que no se distribuyen binarios heredados de forma prematura.

## Etapa B: pruebas de diagnóstico (entorno Windows aislado)

- [ ] Arrancar la futura herramienta en modo lectura sin pedir elevación.
- [ ] Detectar Windows 10 y 11, hardware y configuración actual.
- [ ] Exportar informe diagnóstico sin modificar servicios, políticas ni registro.
- [ ] Validar que cerrar el programa no deja procesos residentes ni tareas programadas.

## Etapa C: pruebas de cambios reversibles (máquina virtual descartable)

- [ ] Crear instantánea de la máquina virtual.
- [ ] Probar cada ajuste individual, nunca todos a la vez.
- [ ] Guardar estado original, aplicar el cambio y verificar el nuevo estado.
- [ ] Revertir con los valores originales, no con valores predeterminados inventados.
- [ ] Verificar reversión cuando hay un fallo intermedio o reinicio.
- [ ] Comprobar Windows Update, ubicación, Xbox, audio, impresión y conexión de red.

## Restricciones permanentes

- Ningún cambio automático al abrir la aplicación.
- No incluir desactivación de Microsoft Defender, SmartScreen, Restauración ni Windows Update en perfiles rápidos.
- Evitar cambios globales a HPET, temporizadores del sistema o prioridades de GPU que prometan rendimiento sin evidencia.
- No ejecutar sobre la PC gamer o de streaming hasta completar las pruebas anteriores.
- Conservar atribución a Hellzerg, licencia GPL-3.0 y código fuente del fork.

## Estado

Esta matriz constituye preparación de pruebas; los checks se actualizarán solamente cuando exista evidencia verificable.
