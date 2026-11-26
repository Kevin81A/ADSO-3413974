# 2. Plan de actividades de análisis (Scrum)

**Marco:** 2 sprints de análisis de 1 semana cada uno (lunes a viernes), con planeación el lunes, revisión con la propietaria el viernes (30 a 45 min por videollamada o en el local) y retrospectiva corta del equipo. Las actividades están **priorizadas** (1 = primero) según el riesgo para el negocio: el checkout y el panel de pedidos van antes que las páginas informativas.

**Roles:** `Kevin81A` = analista y *Product Owner* delegado · Co-desarrollador = *Scrum Master* y apoyo de modelado · Propietaria = *stakeholder* que valida.

| Prioridad | Actividad de análisis | Sprint | Responsable | Fecha (2026) | Entregable | Criterio de terminado |
|---|---|---|---|---|---|---|
| 1 | Planeación del sprint 1: revisar SRS v2.0 y armar el backlog de análisis | S1 | `Kevin81A` | Lun 16 nov | Backlog de análisis priorizado | Cada RF del SRS tiene una historia de análisis |
| 2 | Interpretar el SRS: separar funcionales de no funcionales y detectar vacíos frente al sistema real | S1 | `Kevin81A` | Lun 16 – Mar 17 nov | Catálogo de requisitos v2.1 (`00-insumo-requisitos-srs.md`) | 42 RF y 11 RNF con ID; RF nuevos marcados |
| 3 | Caracterizar la solución y seleccionar la metodología | S1 | `Kevin81A` | Mar 17 nov | `01-caracterizacion-y-metodologia.md` | 4 aspectos y 4 metodologías comparadas |
| 4 | Identificar actores y casos de uso; ajustar el diagrama de casos de uso del equipo | S1 | `Kevin81A` (apoyo: co-desarrollador) | Mié 18 – Jue 19 nov | `diagramas/casos-de-uso.drawio` y `.svg/.png` | ≥ 8 CU, include y extend justificados |
| 5 | Construir la matriz requisito → caso de uso | S1 | `Kevin81A` | Jue 19 nov | `04-matriz-requisito-caso-de-uso.md` | Cobertura ≥ 90 % de RF |
| 6 | Revisión del sprint 1 con la propietaria (validar actores, casos y prioridades) | S1 | `Kevin81A` + propietaria | Vie 20 nov | Notas de revisión en el backlog | Casos críticos acordados: CU-06, CU-15, CU-18 |
| 7 | Detallar casos críticos: diagramas de actividades y plantillas extendidas | S2 | `Kevin81A` | Lun 23 – Mar 24 nov | Producto 2: actividades y plantillas | 2 diagramas y 3 plantillas completas |
| 8 | Modelo de dominio y modelo entidad-relación | S2 | `Kevin81A` (apoyo: co-desarrollador para el MER) | Mar 24 – Mié 25 nov | Producto 2: dominio y MER | ≥ 8 clases; ≥ 6 entidades con N:M resuelta |
| 9 | Prototipo de pantallas de los casos críticos | S2 | Co-desarrollador (revisa `Kevin81A`) | Mié 25 nov | Producto 2: mockups rotulados | 3 pantallas, una por caso crítico |
| 10 | Verificar los modelos con la lista de chequeo, registrar y corregir hallazgos | S2 | `Kevin81A` | Jue 26 – Vie 27 nov | Lista de chequeo y registro de ajustes | ≥ 15 criterios; hallazgos verificados de nuevo |
| 11 | Informe de análisis, matriz de trazabilidad y revisión del sprint 2 con la propietaria | S2 | `Kevin81A` + propietaria | Vie 27 nov | Informe de análisis y matriz (Anexo C) | ≥ 90 % de RF trazados hasta entidad |

**Coherencia con Scrum:** el análisis no se entrega de una sola vez al final; cada viernes hay un incremento revisable (S1: requisitos, metodología, casos de uso y matriz; S2: modelos detallados y verificación). Lo que la propietaria no alcance a validar pasa al backlog del sprint siguiente.

## Cronograma (vista semanal)

| Actividad | L 16 | M 17 | X 18 | J 19 | V 20 | L 23 | M 24 | X 25 | J 26 | V 27 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 Planeación S1 | ■ | | | | | | | | | |
| 2 Interpretar SRS | ■ | ■ | | | | | | | | |
| 3 Caracterizar y seleccionar | | ■ | | | | | | | | |
| 4 Casos de uso | | | ■ | ■ | | | | | | |
| 5 Matriz RF → CU | | | | ■ | | | | | | |
| 6 Revisión S1 | | | | | ◆ | | | | | |
| 7 Actividades y plantillas | | | | | | ■ | ■ | | | |
| 8 Dominio y MER | | | | | | | ■ | ■ | | |
| 9 Prototipo | | | | | | | | ■ | | |
| 10 Verificación y ajustes | | | | | | | | | ■ | ■ |
| 11 Informe y revisión S2 | | | | | | | | | | ◆ |

■ = trabajo · ◆ = revisión de sprint con la propietaria (hito)
