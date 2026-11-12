# Auditoría de General y Windows 11

Windows 11 reutiliza los controles de Windows 10 y añade un panel propio. El inventario incluye controles ocultos y enumera las llamadas directas de cada handler.

- **25H2 (26200) y 26H2 (26300)**. El control bloquea ambos sentidos, también con una compilación desconocida o posterior. [Versiones de Windows 11](https://learn.microsoft.com/en-us/windows/release-health/windows11-release-information)
- **HomeGroup**. Los handlers intentan iniciar o detener `HomeGroupListener` y `HomeGroupProvider` y pueden escribir claves de servicios ausentes. [Retirada de HomeGroup](https://support.microsoft.com/en-gb/windows/experience/connectivity-networking/homegroup-removed-from-windows-10-version-1803)
- **Shell**. Chat escribe `TaskbarMn` y políticas Meet Now. Cortana, People, el mezclador antiguo y el Explorer antiguo requieren verificar si sus claves todavía tienen efecto. [Características retiradas](https://learn.microsoft.com/windows/whats-new/removed-features)
- **Copilot**. `TurnOffWindowsCopilot` es una política obsoleta del Copilot anterior. [WindowsAI Policy CSP](https://learn.microsoft.com/en-gb/windows/client-management/mdm/policy-csp-windowsai)
- **Servicios y tareas**. Verificar SysMain, Fax, WMPNetworkSvc, NvTelemetryContainer, servicios Xbox y tareas Office según edición e instalación. `DisableSystemRestore` intenta borrar instantáneas de C: con `vssadmin` y detener VSS. Defender, SmartScreen, VBS, TPM, SMB y Windows Update requieren revisión de impacto antes de habilitar sus handlers.
- **Comandos**. `Utilities.RunCommand` espera al proceso y omite el código de salida. Un fallo de `sc.exe`, `fsutil` o `powercfg` puede aparentar éxito. El valor `start= enabled` del handler Nvidia requiere revisión. Microsoft retiró WMIC. La búsqueda en C# no encontró invocaciones a `wmic`. [Características retiradas](https://learn.microsoft.com/windows/whats-new/removed-features)
- **Excepciones**. La interfaz registra excepciones propagadas y recupera la posición anterior del interruptor. Los helpers que silencian errores requieren tratamiento propio. Las escrituras previas al fallo pueden persistir. Hace falta la traza de los cuadros de .NET de 16.7 para atribuirles una causa.
- **Validación pendiente**. Probar en VM ambas direcciones por ajuste, edición y compilación, con dependencias presentes y ausentes, permisos insuficientes, error de comando y reinicio si procede. El modo silencioso heredado queda fuera del bloqueo de estas pestañas.

| Pestaña | Control | Handler | Llamadas directas |
| --- | --- | --- | --- |
| General | `enableUtcSw` | `EnableUtcSw_ToggleClicked` | OptimizeHelper.EnableUTCTime, OptimizeHelper.DisableUTCTime |
| General | `noMenuDelaySw` | `NoMenuDelaySw_ToggleClicked` | OptimizeHelper.RemoveMenusDelay, OptimizeHelper.RestoreMenusDelay |
| General | `allTrayIconsSw` | `AllTrayIconsSw_ToggleClicked` | OptimizeHelper.ShowAllTrayIcons, OptimizeHelper.HideTrayIcons |
| General | `disableOneDriveSw` | `toggleSwitch31_Click` | OptimizeHelper.DisableOneDrive, OptimizeHelper.EnableOneDrive |
| General | `winSearchSw` | `WinSearchSw_ToggleClicked` | OptimizeHelper.DisableSearch, OptimizeHelper.EnableSearch |
| General | `nvidiaTelemetrySw` | `NvidiaTelemetrySw_ToggleClicked` | OptimizeHelper.DisableNvidiaTelemetry, OptimizeHelper.EnableNvidiaTelemetry |
| General | `ntfsStampSw` | `NtfsStampSw_ToggleClicked` | OptimizeHelper.DisableNTFSTimeStamp, OptimizeHelper.EnableNTFSTimeStamp |
| General | `smb2Sw` | `Smb2Sw_ToggleClicked` | OptimizeHelper.DisableSMB, OptimizeHelper.EnableSMB |
| General | `smb1Sw` | `Smb1Sw_ToggleClicked` | OptimizeHelper.DisableSMB, OptimizeHelper.EnableSMB |
| General | `hibernateSw` | `HibernateSw_ToggleClicked` | Utilities.DisableHibernation, Utilities.EnableHibernation |
| General | `chromeTelemetrySw` | `ChromeTelemetrySw_ToggleClicked` | OptimizeHelper.DisableChromeTelemetry, OptimizeHelper.EnableChromeTelemetry |
| General | `ffTelemetrySw` | `FfTelemetrySw_ToggleClicked` | OptimizeHelper.DisableFirefoxTelemetry, OptimizeHelper.EnableFirefoxTelemetry |
| General | `vsSw` | `VsSw_ToggleClicked` | OptimizeHelper.DisableVisualStudioTelemetry, OptimizeHelper.EnableVisualStudioTelemetry |
| General | `reportingSw` | `toggleSwitch8_Click` | OptimizeHelper.DisableErrorReporting, OptimizeHelper.EnableErrorReporting |
| General | `systemRestoreSw` | `toggleSwitch4_Click` | OptimizeHelper.DisableSystemRestore, OptimizeHelper.EnableSystemRestore |
| General | `officeTelemetrySw` | `toggleSwitch12_Click` | OptimizeHelper.DisableOffice2016Telemetry, OptimizeHelper.EnableOffice2016Telemetry |
| General | `smartScreenSw` | `ToggleSwitch36_Click` | OptimizeHelper.DisableSmartScreen, OptimizeHelper.EnableSmartScreen |
| General | `networkSw` | `toggleSwitch2_Click` | OptimizeHelper.DisableNetworkThrottling, OptimizeHelper.EnableNetworkThrottling |
| General | `telemetryTasksSw` | `toggleSwitch11_Click` | OptimizeHelper.DisableTelemetryTasks, OptimizeHelper.EnableTelemetryTasks |
| General | `defenderSw` | `toggleSwitch3_Click` | OptimizeHelper.DisableDefender, OptimizeHelper.EnableDefender |
| General | `homegroupSw` | `toggleSwitch9_Click` | OptimizeHelper.DisableHomeGroup, OptimizeHelper.EnableHomeGroup |
| General | `stickySw` | `ToggleSwitch38_Click` | OptimizeHelper.DisableStickyKeys, OptimizeHelper.EnableStickyKeys |
| General | `compatSw` | `toggleSwitch32_Click` | OptimizeHelper.DisableCompatibilityAssistant, OptimizeHelper.EnableCompatibilityAssistant |
| General | `mediaSharingSw` | `toggleSwitch6_Click` | OptimizeHelper.DisableMediaPlayerSharing, OptimizeHelper.EnableMediaPlayerSharing |
| General | `printSw` | `toggleSwitch5_Click` | OptimizeHelper.DisablePrintService, OptimizeHelper.EnablePrintService |
| General | `superfetchSw` | `toggleSwitch10_Click` | OptimizeHelper.DisableSuperfetch, OptimizeHelper.EnableSuperfetch |
| General | `faxSw` | `ToggleSwitch33_Click` | OptimizeHelper.DisableFaxService, OptimizeHelper.EnableFaxService |
| General | `performanceSw` | `toggleSwitch1_Click` | OptimizeHelper.EnablePerformanceTweaks, OptimizeHelper.DisablePerformanceTweaks |
| Windows 11 | `modernStandbySw` | `ModernStandbySw_ToggleClicked` | OptimizeHelper.DisableModernStandby, OptimizeHelper.EnableModernStandby |
| Windows 11 | `newsInterestsSw` | `NewsInterestsSw_ToggleClicked` | OptimizeHelper.DisableNewsInterests, OptimizeHelper.EnableNewsInterests |
| Windows 11 | `hideSearchSw` | `HideSearchSw_ToggleClicked` | OptimizeHelper.HideTaskbarSearch, OptimizeHelper.ShowTaskbarSearch |
| Windows 11 | `hideWeatherSw` | `HideWeatherSw_ToggleClicked` | OptimizeHelper.HideTaskbarWeather, OptimizeHelper.ShowTaskbarWeather |
| Windows 11 | `classicPhotoViewerSw` | `ClassicPhotoViewerSw_ToggleClicked` | OptimizeHelper.RestoreClassicPhotoViewer, OptimizeHelper.DisableClassicPhotoViewer |
| Windows 11 | `edgeAiSw` | `EdgeAiSw_ToggleClicked` | OptimizeHelper.DisableEdgeDiscoverBar, OptimizeHelper.EnableEdgeDiscoverBar |
| Windows 11 | `edgeTelemetrySw` | `EdgeTelemetrySw_ToggleClicked` | OptimizeHelper.DisableEdgeTelemetry, OptimizeHelper.EnableEdgeTelemetry |
| Windows 11 | `vbsSw` | `VbsSw_ToggleClicked` | OptimizeHelper.DisableVirtualizationBasedSecurity, OptimizeHelper.EnableVirtualizationBasedSecurity |
| Windows 11 | `gameModeSw` | `GameModeSw_ToggleClicked` | OptimizeHelper.EnableGamingMode, OptimizeHelper.DisableGamingMode |
| Windows 11 | `storeUpdatesSw` | `ToggleSwitch35_Click` | OptimizeHelper.DisableStoreUpdates, OptimizeHelper.EnableStoreUpdates |
| Windows 11 | `oldMixerSw` | `toggleSwitch13_Click` | OptimizeHelper.EnableLegacyVolumeSlider, OptimizeHelper.DisableLegacyVolumeSlider |
| Windows 11 | `insiderSw` | `ToggleSwitch34_Click` | OptimizeHelper.DisableInsiderService, OptimizeHelper.EnableInsiderService |
| Windows 11 | `castSw` | `ToggleSwitch40_Click` | OptimizeHelper.RemoveCastToDevice, OptimizeHelper.AddCastToDevice |
| Windows 11 | `gameBarSw` | `toggleSwitch15_Click` | OptimizeHelper.DisableGameBar, OptimizeHelper.EnableGameBar |
| Windows 11 | `sensorSw` | `toggleSwitch20_Click` | OptimizeHelper.DisableSensorServices, OptimizeHelper.EnableSensorServices |
| Windows 11 | `ccSw` | `ToggleSwitch37_Click` | OptimizeHelper.DisableCloudClipboard, OptimizeHelper.EnableCloudClipboard |
| Windows 11 | `cortanaSw` | `toggleSwitch16_Click` | OptimizeHelper.DisableCortana, OptimizeHelper.EnableCortana |
| Windows 11 | `privacySw` | `toggleSwitch21_Click` | OptimizeHelper.EnhancePrivacy, OptimizeHelper.CompromisePrivacy |
| Windows 11 | `driversSw` | `toggleSwitch30_Click` | OptimizeHelper.ExcludeDrivers, OptimizeHelper.IncludeDrivers |
| Windows 11 | `telemetryServicesSw` | `toggleSwitch23_Click` | OptimizeHelper.DisableTelemetryServices, OptimizeHelper.EnableTelemetryServices |
| Windows 11 | `autoUpdatesSw` | `toggleSwitch24_Click` | OptimizeHelper.DisableAutomaticUpdates, OptimizeHelper.EnableAutomaticUpdates |
| Windows 11 | `tpmSw` | `TpmSw_ToggleClicked` | OptimizeHelper.DisableTPMCheck, OptimizeHelper.EnableTPMCheck |
| Windows 11 | `xboxSw` | `toggleSwitch17_Click` | OptimizeHelper.DisableXboxLive, OptimizeHelper.EnableXboxLive |
| Windows 11 | `inkSw` | `toggleSwitch29_Click` | OptimizeHelper.DisableWindowsInk, OptimizeHelper.EnableWindowsInk |
| Windows 11 | `spellSw` | `toggleSwitch28_Click` | OptimizeHelper.DisableSpellingAndTypingFeatures, OptimizeHelper.EnableSpellingAndTypingFeatures |
| Windows 11 | `longPathsSw` | `ToggleSwitch39_Click` | OptimizeHelper.EnableLongPaths, OptimizeHelper.DisableLongPaths |
| Windows 11 | `peopleSw` | `toggleSwitch25_Click` | OptimizeHelper.DisableMyPeople, OptimizeHelper.EnableMyPeople |
| Windows 11 | `oldExplorerSw` | `toggleSwitch18_Click` | OptimizeHelper.DisableQuickAccessHistory, OptimizeHelper.EnableQuickAccessHistory |
| Windows 11 | `adsSw` | `toggleSwitch26_Click` | OptimizeHelper.DisableStartMenuAds, OptimizeHelper.EnableStartMenuAds |
| Windows 11 | `copilotSw` | `CopilotSw_ToggleClicked` | OptimizeHelper.DisableCoPilotAI, OptimizeHelper.EnableCoPilotAI |
| Windows 11 | `stickersSw` | `StickersSw_ToggleClicked` | OptimizeHelper.DisableStickers, OptimizeHelper.EnableStickers |
| Windows 11 | `compactModeSw` | `CompactModeSw_ToggleClicked` | OptimizeHelper.EnableFilesCompactMode, OptimizeHelper.DisableFilesCompactMode |
| Windows 11 | `snapAssistSw` | `SnapAssistSw_Click` | OptimizeHelper.DisableSnapAssist, OptimizeHelper.EnableSnapAssist |
| Windows 11 | `widgetsSw` | `WidgetsSw_Click` | OptimizeHelper.DisableWidgets, OptimizeHelper.EnableWidgets |
| Windows 11 | `leftTaskbarSw` | `LeftTaskbarSw_Click` | OptimizeHelper.AlignTaskbarToLeft, OptimizeHelper.AlignTaskbarToCenter |
| Windows 11 | `classicContextSw` | `ClassicContextSw_Click` | OptimizeHelper.DisableShowMoreOptions, OptimizeHelper.EnableShowMoreOptions |
| Windows 11 | `chatSw` | `chatSw_Click` | OptimizeHelper.DisableChat, OptimizeHelper.EnableChat |
