# 4. Lista de chequeo de validación (Anexo B)

Aplicada en dos rondas sobre los artefactos de análisis:

- **1.ª verificación:** sobre los artefactos base del equipo (SRS v2.0, `srs_use_case_diagram.png`, `er_diagram_syp.png`) y mis primeros borradores.
- **2.ª verificación:** después de aplicar los ajustes del [registro de ajustes](05-registro-ajustes.md).

Cada criterio se responde **sí o no** con evidencia. Los criterios C01 a C04 y C18 son de **cobertura o trazabilidad**.

| # | Criterio verificable (sí / no) | Artefacto | 1.ª verif. | Hallazgo | 2.ª verif. | Evidencia |
|---|---|---|---|---|---|---|
| C01 | Cada requisito funcional del SRS aparece en al menos un caso de uso (o está justificado) | Matriz RF → CU | Sí | — | Sí | 41/42 cubiertos; RF-11 justificado ([P1 matriz](../G1-P1-fotocopiadora-syp/04-matriz-requisito-caso-de-uso.md)) |
| C02 | Cada caso de uso traza a al menos un requisito funcional | Matriz RF → CU | **No** | H-01 | Sí | CU-16 y CU-17 no tenían RF; ahora RF-12 y RF-13 |
| C03 | Cada RF se traza hasta clase de dominio y entidad del MER (≥ 90 %) | Matriz de trazabilidad | Sí | — | Sí | 41/42 = 97,6 % ([07-matriz](07-matriz-trazabilidad.md)) |
| C04 | Cada caso crítico tiene una pantalla rotulada | Prototipo | Sí | — | Sí | P-01 (CU-06), P-02 (CU-15), P-03 (CU-18) |
| C05 | Los nombres de los casos de uso son verbo + objeto, un objetivo por caso | Diagrama de CU | **No** | H-03 | Sí | Base: «Gestión CRUD Productos», «Panel y analítica SyP» → «Gestionar productos», «Consultar estadísticas de ventas» |
| C06 | Los actores son roles, no personas | Diagrama de CU | **No** | H-02 | Sí | Base: actores con nombres propios → Administrador, Técnico de soporte |
| C07 | Hay al menos 1 «include» y 1 «extend», cada uno con justificación de una línea | Diagrama de CU | **No** | H-03 | Sí | Base: 0 relaciones → 3 include y 3 extend ([P1 §3.3](../G1-P1-fotocopiadora-syp/03-casos-de-uso.md)) |
| C08 | Casos de uso y plantillas no tienen detalle de implementación (tecnología, bancos, tablas) | CU y plantillas | **No** | H-05 | Sí | Base: «JWT», «PSE, Bancolombia, Nequi» en casos de uso → eliminados |
| C09 | Cada plantilla tiene precondiciones, flujo principal de ≥ 6 pasos, ≥ 1 alterno, ≥ 1 excepción y postcondiciones | Plantillas | Sí | — | Sí | CU-06 (10 pasos), CU-15 (8), CU-18 (8) |
| C10 | Cada rama alterna o de excepción del diagrama de actividades aparece en la plantilla del mismo caso | Actividades y plantillas | Sí | — | Sí | Tablas de decisiones en [01-diagramas-actividades](01-diagramas-actividades.md) |
| C11 | Cada decisión tiene guardas entre corchetes que cubren todas sus salidas | Actividades | Sí | — | Sí | 5 decisiones en CU-06, 3 en CU-15 |
| C12 | Todo concepto usado en las plantillas existe en el modelo de dominio | Dominio | Sí | — | Sí | Carrito, pedido, pago, solicitud, ficha técnica, categoría |
| C13 | El modelo de dominio no tiene métodos ni atributos de clave foránea | Dominio | Sí | — | Sí | 17 clases solo con atributos de negocio |
| C14 | Toda relación N:M del MER está resuelta con entidad asociativa con atributos propios | MER | **No** | H-04 | Sí | Base: `orders.items_json`, `quotes.items_json` → DETALLE_PEDIDO, DETALLE_COTIZACION |
| C15 | Cada entidad del MER tiene identificador | MER | Sí | — | Sí | 15 entidades con PK |
| C16 | Cada relación del MER muestra cardinalidad y participación en la notación declarada | MER | Sí | — | Sí | Pata de gallo en las 15 relaciones |
| C17 | El MER tiene al menos 1 entidad débil o relación recursiva | MER | Sí | — | Sí | VARIANTE_PRODUCTO (débil) y CATEGORIA (recursiva) |
| C18 | El diagrama de casos de uso incluye todas las funciones que pide el SRS | Diagrama de CU | **No** | H-06 | Sí | Base sin mensajes de contacto, historial ni información de la empresa → CU-12, CU-13, CU-14, CU-22 |
| C19 | Cada diagrama tiene fuente editable e imagen | Todos | Sí | — | Sí | `.drawio` + `.svg` + `.png` en `diagramas/` y `prototipo/` |

**Resultado 1.ª verificación:** 12 de 19 cumplen; 7 no cumplen (C02, C05, C06, C07, C08, C14, C18 → hallazgos H-01 a H-06; C05 y C07 comparten el hallazgo H-03).
**Resultado 2.ª verificación:** 19 de 19 cumplen.
