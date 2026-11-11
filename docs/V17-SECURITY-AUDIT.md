# Auditoría inicial — Hellzerg Optimizer 16.7

**Fecha:** 2026-11-11  
**Alcance:** inspección preliminar del código del fork. Aún no hay compilación ni pruebas dinámicas verificadas.  
**Objetivo:** identificar funciones que necesitan protección antes de reutilizarlas en la versión 17.0.

| Riesgo | Fuente | Evidencia / trabajo |
| --- | --- | --- |
| Elevación automática | `Optimizer/Program.cs` | `Main` relanza con `runas` si no hay privilegios. El diagnóstico nuevo deberá funcionar sin elevación. |
| Desactivar seguridad | `Optimizer/Program.cs` | Opciones de línea de comandos `/disabledefender`, `/restart=disabledefender` y flujos en modo seguro. **No usar en perfiles v17.** |
| Cambios masivos y ocultos | `Optimizer/OptimizeHelper.cs` | `EnablePerformanceTweaks` escribe múltiples valores del registro y altera servicios de diagnóstico. Separar en operaciones individuales y reversibles. |
| Reversión potencialmente inexacta | `Optimizer/OptimizeHelper.cs` | `DisablePerformanceTweaks` escribe valores fijos o borra claves sin restaurar necesariamente el estado previo del equipo. Necesario snapshot por ajuste. |
| Actualizaciones y protecciones | `Optimizer/Models/Options.cs` | Contiene `DisableAutomaticUpdates`, `DisableSystemRestore`, `DisableSmartScreen`, `DisableHPET` y `DisableVBS`. Requieren compatibilidad, nivel de riesgo y consentimiento explícito; varias deben excluirse de perfiles. |
| Estado guardado ≠ estado real | `Optimizer/Models/Options.cs` / `Optimizer/OptionsHelper.cs` | La documentación de `Options` dice que cambiar un booleano no aplica el ajuste: no confundir preferencias guardadas con un diagnóstico real del sistema. |
| Dependencia heredada | `Optimizer/Optimizer.csproj` | Proyecto WinForms de .NET Framework 4.8.1 y referencia `System.Management.Automation` ligada a una ruta del sistema. Comprobar que compile en GitHub Actions. |

## Política de la fase 0

- **Solo lectura:** el nuevo script `scripts/Inspect-LegacyRisk.ps1` inspecciona los archivos fuente, no el equipo.
- No ejecutar el programa original ni comandos del sistema para “probar” cambios en Windows del usuario.
- No modificar configuración de antivirus, Windows Update, restauración, arranque, BIOS/HPET ni dispositivos.
- No aprobar releases como seguros sólo por conseguir que MSBuild termine.
- Mantener rama `master` intacta hasta validar y revisar.

## Criterios de salida

1. Compilación del proyecto original en un runner Windows hospedado.
2. Lista revisada de llamadas con privilegios y comandos de cambios al sistema.
3. Diseño de registro de cambios y reversión antes del primer perfil de optimización.
4. Pruebas en máquina virtual o entorno descartable antes de probar en hardware personal.
