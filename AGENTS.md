# AGENTS.md — GymClaude (Flutter)

Instrucciones para cualquier agente de IA (Claude Code, Codex, Cursor…) o persona que construya esta app. `CLAUDE.md` importa este archivo.

## Qué es

**GymClaude**: registro personal de rutinas de gimnasio, **100 % local**. No hay backend, API, cuentas, analítica ni red: toda la lógica de negocio vive en la app y los datos en SQLite. UI en español, tema oscuro, Android primero e iOS después.

Estado actual: proyecto recién creado con `flutter create` (solo `lib/main.dart` de ejemplo). La construcción empieza en la **fase 0**.

## La planificación es la especificación

Todo está decidido y documentado en **`../planificacion/`** (fuera de este repo, en la carpeta padre `gym-claude/`). Si tu herramienta solo ve este directorio, ábrela en `gym-claude/` o pide acceso a la carpeta padre. **No empieces sin poder leerla.**

| Para… | Lee |
|---|---|
| Visión general (siempre, al empezar cada sesión) | `00 - Mapa de Planificación.md`, `03 - Arquitectura General.md`, `13 - Roadmap por Fases.md` |
| Antes de escribir código | `04` Estructura de carpetas → `05` Modelo de dominio → `06` Persistencia → `06b` Esquema físico (DDL + SQL exactos) → `07` Reglas de negocio → `08` Riverpod |
| Navegación | `09 - Navegación (GoRouter).md` |
| Cada pantalla | Su ficha en `features/Feature - *.md` **+** sus capturas en `diseno/capturas/` (índice en `diseno/README.md`) **+** `10 - Design System.md` |
| Notificaciones, widget, deep links, archivos, backup | `11 - Integraciones Externas.md` |
| Tests y CI | `12 - Testing y Calidad.md` |
| Decisiones tomadas y preguntas abiertas | `14 - Decisiones y Preguntas Abiertas.md` |

Las notas usan enlaces de Obsidian `[[Nombre de nota]]` = archivo `Nombre de nota.md` en `planificacion/` (o en `features/`).

### Prioridad cuando algo choca

1. `07 - Reglas de Negocio`, `06b - Esquema Físico` y las fichas de feature.
2. Las capturas de `diseno/capturas/` para lo visual.
3. La lógica del prototipo (`diseno/fuente/logica-pantallas.js`) solo como pista: usa datos simulados y atajos. Las diferencias deliberadas están en `14` → "Correcciones al prototipo".
4. **El compilador manda sobre la sintaxis**: los fragmentos de código de las notas expresan intención; si una API de Riverpod 3, Drift o GoRouter difiere, adapta la sintaxis manteniendo la decisión.

## Método de trabajo

- **Una fase por vez**, en el orden de `13 - Roadmap por Fases.md`. Fases grandes (3, 4, 6, 7): divídelas por feature y cierra cada parte con tests en verde.
- Dentro de cada feature, **de dentro hacia fuera**: `domain → data → application → presentation → ruta → tests`. Cada paso compila.
- **No avances de fase** sin cumplir la *definition of done* de `13` (análisis limpio, generados al día, tests de la fase en verde, `architecture_test` en verde).
- Antes de una pantalla, **mira sus capturas** (todas las partes `-1`, `-2`…) y replica disposición, espaciado y textos con los tokens del design system.
- **Para y pregunta** antes de: cambiar una decisión ADR de `14`, cambiar el esquema de BD respecto a `06b`, añadir una dependencia que no esté en `02 - Stack Tecnológico.md`, añadir cualquier cosa que use red, o borrar datos/archivos que no creaste.
- Preguntas abiertas de `14`: aplica el **valor por defecto** indicado y sigue; no bloquees.
- Al cerrar una fase, actualiza la tabla **Estado** al final de este archivo y, si cambió algo de la planificación, la nota correspondiente (con una línea que explique el cambio).

## Comandos

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # tras tocar Freezed / Riverpod / Drift
dart run build_runner watch --delete-conflicting-outputs   # durante el desarrollo
dart format .
flutter analyze
dart run custom_lint                                       # riverpod_lint
flutter test                                               # todo
flutter test test/features/workout                         # una carpeta
flutter test --plain-name "StreakCalculator"               # por nombre
dart run drift_dev make-migrations                         # tras cambiar el esquema (a partir de la 1.ª versión instalada)
flutter build apk --debug                                  # comprobar que Android compila
```

## Reglas de arquitectura (resumen; detalle en `03`, `04`, `08`)

- Carpetas **feature-first** en `lib/src/features/<feature>/{domain,data,application,presentation}`; núcleo compartido en `lib/src/core/`, UI compartida en `lib/src/design_system/`, rutas en `lib/src/routing/`, integraciones con el SO en `lib/src/integrations/`.
- Dependencias: `presentation → application → data → domain`. `domain` es **Dart puro** (sin Flutter, Drift ni Riverpod). `presentation` nunca importa Drift ni `data/`. Un feature solo usa de otro su `application` o su `domain`. Nada fuera de `integrations/` importa `integrations/`.
- Archivos `*_calculator|_detector|_planner|_builder|_renderer.dart` son **puros**.
- La lógica de negocio va en **servicios (`application`) y calculadoras (`domain`)**, nunca en controllers ni widgets.
- **Lecturas = `Stream`** desde Drift (`watch()`); **escrituras = `Future`** en servicios. No se invalidan ni refrescan providers a mano tras escribir.
- **Nada derivado se guarda** (racha, récords, máximos, totales): se calcula.
- Pesos siempre en **kg** en BD; la unidad (kg/lb) es de presentación y **por ejercicio**.
- Nunca `DateTime.now()` en lógica: usa `clockProvider` / `todayProvider`.
- Tablas y consultas en archivos **`.drift`** (SQL) por feature dueño, copiando `06b`. `ProgressDao` es el único que lee tablas de varios features y no escribe.
- Riverpod **solo con codegen** (`@riverpod` / `@Riverpod(keepAlive: true)`). Infraestructura, repos y servicios `keepAlive`; lecturas y controllers `autoDispose`.
- Navegación solo con `AppRoute` + helpers tipados de `routing/routes.dart`. Prohibido `context.go('/ruta')` con cadenas fuera de `routing/` y prohibido `state.extra`: solo ids en ruta y opciones en *query params*.
- Sin literales de color, tamaño de texto, radio o espaciado en features: tokens de `design_system`. Sin textos visibles fuera de `l10n/app_es.arb`.
- Cada pantalla implementa estados **vacío, cargando, error y datos**.

## Convenciones

- Código, clases, archivos y carpetas en **inglés**; textos de UI en **español** vía `l10n`.
- Nombres: `<x>.drift`, `<x>_dao.dart`, `<x>_repository.dart` (interfaz), `drift_<x>_repository.dart`, `<x>_service.dart`, `<x>_controller.dart`, `<x>_screen.dart`. El provider se declara al final del archivo de la clase que expone.
- Imports con `package:gym_claude/...`.
- Archivos generados (`*.g.dart`, `*.freezed.dart`, `*.drift.dart`) **se commitean** y nunca se editan a mano.
- Tests en `test/` reflejando `lib/src/`. Servicios se prueban contra **Drift en memoria** (`NativeDatabase.memory()`) con reloj fijo; mocks solo para puertos del SO. Dataset y fecha de demostración: lunes 22-jun-2026 (`12`).
- Commits pequeños, **Conventional Commits** en inglés con alcance de feature: `feat(workout): add set logging`, `test(progress): cover streak rules`, `chore(core): set up drift database`.

## Entorno y límites conocidos

- **JDK**: compilar Android requiere JDK 17 o 21. Con JDK 25 Gradle falla (`What went wrong: 25.0.2`). Si ocurre, avisa; **no** cambies versiones de Gradle/AGP ni la configuración global para esquivarlo.
- **iOS** (incluido el widget WidgetKit y el build para App Store) necesita macOS + Xcode. En Linux: escribe el código Dart compartido, deja la parte nativa de iOS anotada como pendiente en la tabla Estado y continúa.
- **Sin red en tiempo de ejecución**: ningún paquete que la necesite; fuentes empaquetadas en `assets/fonts/` (no `google_fonts`). El manifiesto de *release* no debe declarar `INTERNET`.
- Identificadores (fase 0): `applicationId` / bundle id `com.gymclaude.app` (hoy son `com.example.gym_claude`); nombre visible "GymClaude". Borrar `web/`, `linux/`, `macos/`, `windows/`.

## Estado

| Fase | Contenido | Estado | Notas |
|---|---|---|---|
| 0 | Fundaciones | Completada | Core, Shared Kernel, Drift base, Design System, GoRouter 4 pestañas, l10n (`es`) y `architecture_test` en verde |
| 1 | Ajustes + Ejercicios | Completada | Settings (singleton id=1, wipeAllData atómico con evento en bus, debounce, stepper, switches), Exercises (12 ejercicios semilla, búsqueda sin acentos/case-insensitive, borrado físico/lógico según historial, restauración al recrear), pantallas List/Detail/Form y 74 tests en verde |
| 2 | Rutinas | Pendiente | |
| 3 | Sesión activa | Pendiente | |
| 4 | Progreso + Inicio | Pendiente | |
| 5 | Historial | Pendiente | |
| 6 | Exportación | Pendiente | |
| 7 | Integraciones | Pendiente | |
| 8 | Backup, pulido, publicación | Pendiente | |
